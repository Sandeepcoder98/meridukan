class Api::V1::SessionsController < DeviseController
  skip_before_filter :verify_authenticity_token, :only => :create

  prepend_before_filter :require_no_authentication, :only => [:create ]
  
  before_filter :ensure_params_exist

  respond_to :json
  
  def create
    debugger 
    resource = User.find_for_database_authentication(:mobile=>params[:user][:mobile])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render :json=> { status: true, message: 'logged in successfully',details:{:auth_token=>resource.authentication_token, :mobile=>resource.mobile,:current_lat=>resource.current_lat, :current_lng=>resource.current_lng,:device_type=>resource.device_type, :device_token=>resource.device_token,:role=>resource.roles.first.name }  }
      # render :json=> resource.as_json(:auth_token=>resource.authentication_token, :mobile=>resource.mobile), :status=>200
      return
    end
    invalid_login_attempt
  end
  
  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:user].blank?
    render :json=>{:success=>false, :message=>"missing user parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end