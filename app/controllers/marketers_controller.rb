class MarketersController < ApplicationController
  before_action :set_marketer, only: [:show, :edit, :update, :destroy]

  def index
    @marketers = Marketer.all
     new
    respond_to do |format|
     	format.html
      format.xlsx
    end
  end

  def new
    @marketer = Marketer.new
  end

  def edit
  end

  def create
    @marketer = Marketer.new(marketer_params)
    if @marketer.valid?
      @marketer.save
      flash[:notice] = "Marketer created successfully."
      render :js => "window.location = '#{marketers_path}'"
    else
      flash[:alert] = @marketer.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def update
  	if @marketer.update_attributes(marketer_params)
      flash[:notice] = "Marketer updated successfully."
      render :js => "window.location = '#{marketers_path}'"
    else
      flash[:alert] = @marketer.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end

  def destroy
  	@marketer.destroy!
    flash[:notice] = "Marketer deleted successfully."
    redirect_to marketers_path
  end

  private
    def set_marketer
      @marketer = Marketer.find(params[:id])
    end

    def marketer_params
      params.require(:marketer).permit(:name,:description,:foreign)
    end
end
