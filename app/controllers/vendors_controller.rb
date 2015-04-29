class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]


  def index
    @vendors = Vendor.all
    new
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end


  def new
    @vendor = Vendor.new
    @vendor_categories = VendorCategory.order(:name)
    @states = State.all
  end


  def edit
  	@vendor_categories = VendorCategory.order(:name)
    @states = State.all
  end


  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.valid?
      @vendor.save
      flash[:notice] = "Vendor created successfully."
      render :js => "window.location = '#{vendors_path}'"
    else
      flash[:alert] = @vendor.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def update
   if @vendor.update_attributes(vendor_params)
      flash[:notice] = "Vendor updated successfully."
      render :js => "window.location = '#{vendors_path}'"
    else
      flash[:alert] = @vendor.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def destroy
    @vendor.destroy!
    flash[:notice] = "Vendor deleted successfully."
    redirect_to vendors_path
  end

  private

    def set_vendor
      @vendor = Vendor.find(params[:id])
    end


    def vendor_params
      params.require(:vendor).permit(:name, :address,:reg_number,:state_id,:store_id,:contact_email, :contact_name, :contact_mobile,:vendor_category_id)
    end
end
