class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with 
  name: Rails.configuration.admin[:name], 
  password: Rails.configuration.admin[:password]
  def show
    @product_count = Product.all()
    @category_count = Category.all()
  end
end
