class StaffCategoriesController < ApplicationController
  before_action :set_staff_category, only: [:show, :edit, :update, :destroy]

  def index
    @staff_categories = StaffCategory.all
    new
    respond_to do |format|
     	format.html
      format.xlsx
      end
  end

  def new
    @staff_category = StaffCategory.new
  end


  def edit
  end


  def create
    @staff_category = StaffCategory.new(staff_category_params)
    if @staff_category.valid?
      @staff_category.save
      flash[:notice] = "Staff Category created successfully."
      render :js => "window.location = '#{staff_categories_path}'"
    else
      flash[:alert] = @staff_category.errors.full_messages  
      render :partial =>  'shared/errors'
    end
  end


  def update
    @staff_category.attributes = staff_category_params
    if @staff_category.save
      @staff_category.save
      flash[:notice] = "Staff Category updated successfully."
      render :js => "window.location = '#{staff_categories_path}'"
    else
      flash[:alert] = @staff_category.errors.full_messages  
      render :partial =>  'shared/errors'
    end  
  end


  def destroy
    @staff_category.destroy!    
    flash[:notice] = "Staff Category deleted successfully."
    redirect_to staff_categories_path
  end

  private

    def set_staff_category
      @staff_category = StaffCategory.find(params[:id])
    end


    def staff_category_params
      params.require(:staff_category).permit(:name,:description)
    end
end
