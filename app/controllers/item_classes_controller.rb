class ItemClassesController < ApplicationController
  before_action :set_item_class, only: [:show, :edit, :update, :destroy]


  def index
    @item_classes = ItemClass.all
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end


  def new
    @item_class = ItemClass.new
    @item_class.sub_classes.build
  end


  def edit
  	@item_class.sub_classes.build
  end


  def create
    @item_class = ItemClass.new(item_class_params)
    if @item_class.valid?
      @item_class.save
      flash[:notice] = "Item Class created successfully."
      render :js => "window.location = '#{item_classes_path}'"
    else
      flash[:alert] = @item_class.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def update
    if @item_class.update_attributes(item_class_params)
      flash[:notice] = "Item Class updated successfully."
      render :js => "window.location = '#{item_classes_path}'"
    else
      flash[:alert] = @item_class.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def destroy
    @item_class.destroy!    
    flash[:notice] = "Item Class deleted successfully."
    redirect_to item_classes_path
  end

  private

    def set_item_class
      @item_class = ItemClass.find(params[:id])
    end

    def item_class_params
      params.require(:item_class).permit(:name,:description,sub_classes_attributes: [:id,:name, :description,:_destroy] )
    end
end
