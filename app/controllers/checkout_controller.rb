class CheckoutController < ApplicationController
  before_action :set_order, only: :order_response

  # Checking the status of the user mobile number 
  # If user is new than we are sending otp password
  def get_started
  	@user, @user_partial = User.find_and_assign_form(params[:mobile])
  end

  def action_login 
    resource = User.find_for_database_authentication(:mobile=>params[:user][:mobile])
    if resource && resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
    end
  end

  def resend_otp_password
    user = User.find_by_mobile(params[:mobile])
    user.update_new_password_and_send_otp
  end

  def delivery_address
    @addresses = current_user.shipping_addresses
  end

  def add_delivery_address
    shipping_address = current_user.shipping_addresses.create(shipping_address_params)
    current_user.set_default_address shipping_address.id
  end

  def deliver_here
    current_user.set_default_address params[:id]
  end

  def payment_method
  end

  def cash_on_delivery
  end

  def order_response
    @order.placed(current_user)
    @order.save_notification if session[:order_id]
    session[:order_id] = nil
  end

  private 

  def shipping_address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :mobile, :address, :city, :state, :country, :pin_code)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end

