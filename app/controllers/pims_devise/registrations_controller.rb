class PimsDevise::RegistrationsController < Devise::RegistrationsController

 def new
		@user = User.new
		@titles = Title.order(:name)
		@staffcategories = StaffCategory.order(:name)
		@stores = Store.joins(:roles).uniq
	end

 def create
		@user = User.new(user_sign_up)
		if @user.valid?
			role_array = params[:user][:roles].reject! { |c| c.empty? }
			@user.role_ids = role_array if role_array.present?
			@user.save!
			redirect_to users_path
		else
			@titles = Title.order(:name)
			@staffcategories = StaffCategory.order(:name)
			@stores = Store.joins(:roles).uniq
			flash[:alert] = @user.errors.full_messages
			render 'new'
		end
	end

	private

  def user_sign_up
    params.require(:user).permit(:title_id, :first_name, :last_name, :username,{:store_ids=>[]},:staff_category_id, :admin,:active_status, :validity,:password, :password_confirmation)
  end


end

