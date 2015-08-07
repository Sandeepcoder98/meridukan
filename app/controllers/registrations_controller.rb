class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create]

  protected

  def configure_permitted_parameters
    params[:user][:password]=User.generated_password
    devise_parameter_sanitizer.for(:sign_up)
  end

  def sign_up(resource_name, resource)
    true
  end

  def after_sign_up_path_for(resource)
  	User.send_otp(params[:user][:password], params[:user][:mobile])
    session[:mobile]=params[:user][:mobile]
  	flash[:success] = "We have send your otp / password at "+params[:user][:mobile]
    verify_otp_path
  end
end