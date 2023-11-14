class Admin::CategoriesController < ApplicationController
  # Enable HTTP basic authentication with the specified credentials
  http_basic_authenticate_with 
  name:  Rails.configuration.admin[:name], 
  password: Rails.configuration.admin[:password]

  # Display a list of all categories in descending order of ID
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end
  
  # Create a new category based on the submitted parameters
  def create
    @category = Category.new(category_params)

    if @category.save
      # Redirect to the admin categories index page with a success notice
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      # Render the new category form again if save is unsuccessful
      render :new
    end
  end

  private
  
  # Define strong parameters for the category
  def category_params
    params.require(:category).permit(
      :name
    )
  end
end