class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:create]

  protected

  def configure_permitted_parameters
    params[:user][:password]=12345678
    devise_parameter_sanitizer.for(:sign_up)
  end
end