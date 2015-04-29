class ItemConcentrationUnitsController < ApplicationController
  before_action :set_item_concentration_unit, only: [:show, :edit, :update, :destroy]


  def index
    @item_concentration_units = ItemConcentrationUnit.all
    new
     respond_to do |format|
     	format.html
      format.xlsx
    end
  end


  def new
    @item_concentration_unit = ItemConcentrationUnit.new
  end

  def edit
  end

  def create
    @item_concentration_unit = ItemConcentrationUnit.new(item_concentration_unit_params)
    if @item_concentration_unit.valid?
      @item_concentration_unit.save
      flash[:notice] = "Item Concentration Unit created successfully."
      render :js => "window.location = '#{item_concentration_units_path}'"
    else
      flash[:alert] = @item_concentration_unit.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def update
    @item_concentration_unit.attributes = item_concentration_unit_params
    if @item_concentration_unit.update_attributes(item_concentration_unit_params)
      flash[:notice] = "Item Concentration Unit updated successfully."
      render :js => "window.location = '#{item_concentration_units_path}'"
    else
      flash[:alert] = @item_concentration_unit.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def destroy
    @item_concentration_unit.destroy!
    flash[:notice] = "Item Concentration Unit deleted successfully."
    redirect_to item_concentration_units_path
  end

  private

    def set_item_concentration_unit
      @item_concentration_unit = ItemConcentrationUnit.find(params[:id])
    end

    def item_concentration_unit_params
      params.require(:item_concentration_unit).permit(:name,:description)
    end
end
