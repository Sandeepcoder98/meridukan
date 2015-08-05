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
    new_user_session_path
  end
end