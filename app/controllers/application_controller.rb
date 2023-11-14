class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end

  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
      # Set the cart value in cookies as a JSON string with an expiration of 10 days from now

    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
      # Return the updated cart stored in the cookies

    cookies[:cart]
  end

  # Retrieves the current user based on the user_id stored in the session
  # Returns:
  # - The current user if a user is logged in, otherwise nil
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # Redirects to the login page unless a user is logged in
  # Used as a before_action filter in controllers to ensure authorization
  def authorize
    redirect_to '/login' unless current_user
  end
end
