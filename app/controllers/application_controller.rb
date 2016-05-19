class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource
  helper_method :current_order
  helper_method :current_admin



  
  def current_order
    begin
      if !session[:order_id].nil?
        Order.find(session[:order_id])
      else
        Order.new
      end
    rescue
      Order.new
    end
  end

  def current_admin
    ((current_user.nil?) || (!current_user.has_role? :admin))
  end


  protected

  def layout_by_resource
    if (params[:controller]=="registrations" && params[:action]=="update")
      "application"
    elsif devise_controller?
      "members"
    else
      "application"
    end
  end
end
