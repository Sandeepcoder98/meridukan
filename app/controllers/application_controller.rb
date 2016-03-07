class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  layout :layout_by_resource
  helper_method :current_order

  def after_sign_in_path_for(resource)
      authenticated_root_path
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "members"
    else
      "application"
    end
  end
end
