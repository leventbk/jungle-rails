class Admin::ProductsController < ApplicationController
  # Enable HTTP basic authentication with the specified credentials
  http_basic_authenticate_with 
  name: Rails.configuration.admin[:name], 
  password: Rails.configuration.admin[:password]

  # Display a list of all products in descending order of ID
  def index
    @products = Product.order(id: :desc).all
  end
  
  # Render a form for creating a new product
  def new
    @product = Product.new
  end

  # Create a new product based on the submitted parameters
  def create
    @product = Product.new(product_params)

    if @product.save
      # Redirect to the admin products index page with a success notice
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      # Render the new product form again if save is unsuccessful
      render :new
    end
  end

  # Delete a product based on the specified ID
  def destroy
    @product = Product.find params[:id]
    @product.destroy
     # Redirect to the admin products index page with a success notice
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  # Define strong parameters for the product
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
