class ItemConcentrationUnitsController < ApplicationController
  before_action :set_item_concentration_unit, only: [:show, :edit, :update, :destroy]


  def index
    @item_concentration_units = ItemConcentrationUnit.all
    new
  end


  def new
    @item_concentration_unit = ItemConcentrationUnit.new
  end

  def edit
  end

  def create
    @item_concentration_unit = ItemConcentrationUnit.new(item_concentration_unit_params)
    @error = @item_concentration_unit.error.full_messages
  end

  def update
      @item_concentration_unit.update!(item_concentration_unit_params)
      @error = @item_concentration_unit.error.full_messages
  end


  def destroy
    @item_concentration_unit.destroy!
    @error = @item_concentration_unit.error.full_messages
  end

  private

    def set_item_concentration_unit
      @item_concentration_unit = ItemConcentrationUnit.find(params[:id])
    end

    def item_concentration_unit_params
      params.require(:item_concentration_unit).permit(:name,:description)
    end
end
