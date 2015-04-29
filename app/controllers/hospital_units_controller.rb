class HospitalUnitsController < ApplicationController
  before_action :set_hospital_unit, only: [:show, :edit, :update, :destroy]
  respond_to :html,:pdf,:js


  def index
    @hospital_units = HospitalUnit.all
    new
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end


  def new
    @hospital_unit = HospitalUnit.new
  end


  def edit
  end


  def create
    @hospital_unit = HospitalUnit.new(hospital_unit_params)
    if @hospital_unit.valid?
      @hospital_unit.save
      flash[:notice] = "Hospital Unit created successfully."
      render :js => "window.location = '#{hospital_units_path}'"
    else
      flash[:alert] = @hospital_unit.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def update
    if @hospital_unit.update_attributes(hospital_unit_params)
      flash[:notice] = "Hospital Unit updated successfully."
      render :js => "window.location = '#{hospital_units_path}'"
    else
      flash[:alert] = @hospital_unit.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def destroy
    @hospital_unit.destroy!
    flash[:notice] = "Hospital Unit deleted successfully."
    redirect_to hospital_units_path
  end

  private

    def set_hospital_unit
      @hospital_unit = HospitalUnit.find(params[:id])
    end

    def hospital_unit_params
      params.require(:hospital_unit).permit(:name, :description)
    end

end
