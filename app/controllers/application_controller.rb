class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
 
  layout :layout_by_resource
  helper_method :current_order
  
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

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
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
