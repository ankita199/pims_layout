class StoreOperationsController < ApplicationController
  before_action :set_store_operation, only: [ :edit, :update, :destroy]

  def index
    @store_operations = StoreOperation.all
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end

  def new
    @store_operation = StoreOperation.new
  end

  def create
    @store_operation = StoreOperation.new(store_operation_params)
    if @store_operation.valid?
      @store_operation.save
      flash[:notice] = "Store Operation created successfully."
      render :js => "window.location = '#{store_operations_path}'"
    else
      flash[:alert] = @store_operation.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def edit
  end

  def update
    if @store_operation.update_attributes(store_operation_params)
      flash[:notice] = "Store Operation updated successfully."
      render :js => "window.location = '#{store_operations_path}'"
    else
      flash[:alert] = @store_operation.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def destroy
    @store_operation.destroy!
    flash[:notice] = "Store Operation deleted successfully."
    redirect_to store_operations_path
  end

  private
    def set_store_operation
      @store_operation = StoreOperation.find(params[:id])
    end


    def store_operation_params
      params.require(:store_operation).permit(:name, :description,:payment_required)
    end
end
