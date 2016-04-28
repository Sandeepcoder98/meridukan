class Api::V1::RegistrationsController < DeviseController
  
  skip_before_filter :verify_authenticity_token, :only => :create

  respond_to :json
  def create
    user = User.new(sign_up_params)
    if user.save && params[:role]
      user.add_user_role(params[:role])
      User.send_otp(params[:user][:password], params[:user][:mobile])
      render :json=> user.as_json(:auth_token=>user.authentication_token, :mobile=>user.mobile), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
  end

  def sign_up_params
  	params[:user][:password]=User.generated_password
    params.require(:user).permit(:mobile, :password)
  end

end
