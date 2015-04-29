class UsersController < ApplicationController
	before_action :set_user, except: [:index,:password_edit,:password_change]


  def index
  	@users = User.all
  	@stores = Store.all
  end


  def edit
    @titles = Title.order(:name)
    @staffcategories = StaffCategory.order(:name)
    @stores = Store.joins(:roles).uniq
  end


  def update    
    if @user.update_attributes(user_params)
      role_array = params[:user][:roles].reject! { |c| c.empty? }
      @user.role_ids = role_array if role_array.present?
      @user.save!
      redirect_to users_path
    else
      @titles = Title.order(:name)
      @staffcategories = StaffCategory.order(:name)
      @stores = Store.joins(:roles).uniq
      flash[:alert] = @user.errors.full_messages
      render 'edit'
    end
  end


  def password_reset
  	@user.password_reset!
  	@error = @user.errors.full_messages.to_sentence
  end

  def password_edit
    @user = User.find(me.id)
  end


  def password_change
  	me = params[:id].to_i
  	@user = User.find(me)
  	logger.debug{"User ID: #{@user.id }"}
     password_status = @user.password_change_check?(params[:user][:current_password],params[:user][:password])
   	 if @user.update_with_password(user_password)&& (password_status == false)
     sign_in @user, :bypass => true
       if @user.has_role? :admin
          	redirect_to dashboard_path
           else
           	 redirect_to store_selections_index_path
          end
      else
      	 render :password_edit
   end
  end

  def destroy
    @user.destroy!
    flash[:notice] = "User deleted successfully."
    redirect_to users_path
  end

  private

  def set_user
  	@user = User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:title_id, :first_name, :last_name, :username,{:store_ids=>[]},:staff_category_id, :role_ids,:active_status, :validity)
  end

  def user_password
  	params.required(:user).permit(:current_password, :password, :password_confirmation)
  end

end
