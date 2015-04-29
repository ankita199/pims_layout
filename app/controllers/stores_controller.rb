class StoresController < ApplicationController

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  def index
    @stores = Store.all
    new
  end

  def new
    @store = Store.new
    @stores = Store.all
    #@roles = @store.roles.build
    @store_operations = StoreOperation.all
    @store_types = StoreType.all
  end


  def edit
    @stores = Store.all
  end


  def create
    @store = Store.new(store_params)
    params[:store][:role_ids].reject! { |c| c.empty? }.each do |role|
      @store.roles.build(:name => role)
    end
    if @store.valid?
      @store.save
      flash[:notice] = "Store created successfully."
      render :js => "window.location = '#{stores_path}'"
    else
      flash[:alert] = @store.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def update
    if @store.update_attributes(store_params)
      roles = params[:store][:role_ids].reject! { |c| c.empty? }
      store_roles = @store.roles.pluck(:name)
      roles.each do |r|
        if !(store_roles.include? r)
          @store.roles.build(:name => r)
        end
      end
      extra_roles = store_roles - roles
      @store.roles.where("name in (?)",extra_roles).destroy_all
      @store.save
      flash[:notice] = "Store updated successfully."
      render :js => "window.location = '#{stores_path}'"
    else
      flash[:alert] = @store.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def destroy
    @store.destroy!
    flash[:notice] = "Store deleted successfully."
    redirect_to stores_path
  end

  private

    def set_store
      @store = Store.find(params[:id])
    end


    def store_params
      params.require(:store).permit(:name, :store_type_id, :role_ids ,:parent_store,:operation_mode, :open_time, :close_time,:parent_id,:store_operation_id)
    end
end
