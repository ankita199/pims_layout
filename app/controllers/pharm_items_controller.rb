class PharmItemsController < ApplicationController
  before_action :set_pharm_item, only: [:show, :edit, :update, :destroy]

  def index
    @pharm_items  = PharmItem.all
    new
     respond_to do |format|
     	  format.html
        format.xlsx
    end
  end

  def new
    @pharm_item = PharmItem.new
    @pharm_item.brands.build
 end

  def edit
  end


  def create
    @pharm_item = PharmItem.new(pharm_item_params)
    @pharm_item.pharm_item_sub_classes.build(params[:sub_class_ids])if (params[:sub_class_ids]).present?
    if @pharm_item.valid?
      @pharm_item.critical_levels
      @pharm_item.save
      flash[:notice] = "Pharm Item created successfully."
      redirect_to pharm_items_path
    else
      flash[:alert] = @pharm_item.errors.full_messages
      @pharm_item.brands.build
      render 'new'
    end
  end


  def update
    if @pharm_item.update_attributes(pharm_item_params)
      @pharm_item.critical_levels
      @pharm_item.save
      flash[:notice] = "Pharm Item created successfully."
      redirect_to pharm_items_path
    else
      flash[:alert] = @pharm_item.errors.full_messages
      render 'edit'
    end
  end


  def destroy
    @pharm_item.destroy!
    flash[:notice] = "Pharm Item deleted successfully."
    redirect_to pharm_items_path
  end

  private
    def set_pharm_item
      @pharm_item = PharmItem.find(params[:id])
    end

    def pharm_item_params
      params.require(:pharm_item).permit(:name,{:sub_class_ids=>[]},:central_restock_level,:central_critical_level,:main_restock_level,
      :main_critical_level,:dispensary_restock_level,:dispensary_critical_level,:ward_restock_level,:ward_critical_level,
      brands_attributes: [:id, :name,:pack_bundle, :marketer_id, :unit_dose_id, :concentration, :item_concentration_unit_id, :pack_size,:pharm_item_id,:min_dispensable,:_destroy])
    end
end
