class StoreTypesController < ApplicationController
  before_action :set_store_type, only: [:show, :edit, :update, :destroy]


  def index
    @store_types = StoreType.all
    new
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end

  def new
    @store_type = StoreType.new
  end

  def create
    @store_type = StoreType.new(store_type_params)
    if @store_type.valid?
      @store_type.save
      flash[:notice] = "Store Type created successfully."
      render :js => "window.location = '#{store_types_path}'"
    else
      flash[:alert] = @store_type.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def edit
  end

  def update
    if @store_type.update_attributes(store_type_params)
      flash[:notice] = "Store Type updated successfully."
      render :js => "window.location = '#{store_types_path}'"
    else
      flash[:alert] = @store_type.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def destroy
    @store_type.destroy!
    flash[:notice] = "Store Type deleted successfully."
    redirect_to store_types_path
  end

  private

    def set_store_type
      @store_type = StoreType.find(params[:id])
    end

    def store_type_params
      params.require(:store_type).permit(:name,:description)
    end
end
