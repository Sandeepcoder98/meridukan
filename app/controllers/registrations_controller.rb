class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create]

  protected

  def configure_permitted_parameters
    params[:user][:password]=generated_password
    devise_parameter_sanitizer.for(:sign_up)
  end

  def generated_password
  	generated_password = Devise.friendly_token.first(8)
  end

  def sign_up(resource_name, resource)
    true
  end

  def after_sign_up_path_for(resource)
  	send_message(params[:user][:password], params[:user][:mobile])
  	flash[:success] = "We have send your password on "+params[:user][:mobile]
    new_user_session_path
  end

  def send_message(password,mobile)
  	mobile="+91#{mobile}"
  	message = TwilioClient.account.messages.create({
		:from => '+17548884078', 
		:to => mobile, 
		:body => password,  
	}) rescue false
  end
end