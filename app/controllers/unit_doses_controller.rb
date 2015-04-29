class UnitDosesController < ApplicationController
  before_action :set_unit_dose, only: [:show, :edit, :update, :destroy]



  def index
    @unit_doses = UnitDose.all
    new
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end

  def new
    @unit_dose = UnitDose.new
  end


  def edit
  end


  def create
    @unit_dose = UnitDose.new(unit_dose_params)
    if @unit_dose.valid?
      @unit_dose.save
      flash[:notice] = "Unit Dose created successfully."
      render :js => "window.location = '#{unit_doses_path}'"
    else
      flash[:alert] = @unit_dose.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def update
    if @unit_dose.update_attributes(unit_dose_params)
      flash[:notice] = "Unit Dose updated successfully."
      render :js => "window.location = '#{unit_doses_path}'"
    else
      flash[:alert] = @unit_dose.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def destroy
  	@unit_dose.destroy!
    flash[:notice] = "Unit Dose deleted successfully."
    redirect_to unit_doses_path
  end

  private

    def set_unit_dose
      @unit_dose = UnitDose.find(params[:id])
    end

    def unit_dose_params
      params.require(:unit_dose).permit(:name, :form_type)
    end
end
