class PasswordsController < Devise::PasswordsController

  # POST /resource/password
  def create
    user = User.find_by_mobile(params[:mobile])
    if user
      user.update_new_password_and_send_otp
      flash[:success]="We have send your OTP / password at #{user[:mobile]}"
    else
      flash[:alert]="You have entered the wrong information"
    end
    redirect_to :back
  end

end