class SurchargesController < ApplicationController
	before_action :set_surcharge, only: [:edit,:update,:destroy]
	before_action :set_all_surcharges, only: [:index]
	#respond_to :html


  def index
  end

  def new
  	@surcharge = Surcharge.new
    @surcharge.surcharge_items.build
  end

  def edit
   	@surcharge.surcharge_items.build
  end


  def create
  	@surcharge = Surcharge.new(surcharge_params)
    if @surcharge.valid?
      @surcharge.save
      flash[:notice] = "Surcharge created successfully."
      render :js => "window.location = '#{surcharges_path}'"
    else
      flash[:alert] = @surcharge.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def update
    if @surcharge.update_attributes(surcharge_params)
      @surcharge.save
      flash[:notice] = "Surcharge updated successfully."
      render :js => "window.location = '#{surcharges_path}'"
    else
      flash[:alert] = @surcharge.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def destroy
    @surcharge.destroy!    
    flash[:notice] = "Surcharge deleted successfully."
    redirect_to surcharges_path
  end


  private

  def set_surcharge
  	@surcharge = Surcharge.find(params[:id])
  end

  def set_all_surcharges
  	@surcharges = Surcharge.all
  end

  def surcharge_params
    params.require(:surcharge).permit(:name, :charge_type, :active,surcharge_items_attributes: [:id,:name, :description,:value, :_destroy])
  end
end
