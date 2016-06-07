class Api::V1::PasswordsController < DeviseController
  skip_before_filter :verify_authenticity_token, :only => :create
  respond_to :json
  # POST /resource/password
  def create
    user = User.find_by_mobile(params[:mobile])
    if user
    	user.update_new_password_and_send_otp
      	render :json=> { status: true, message: "We have send your OTP / password at #{user[:mobile]}" }, :status=>201
      return
    else
      render :json=> { status: false, message: "You have entered the wrong information"}, :status=>422
    end
  end
end