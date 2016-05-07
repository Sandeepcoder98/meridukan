class CheckoutController < ApplicationController
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
end

