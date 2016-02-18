class SocialController < ApplicationController
	layout "members"
	def signup
	end

	def main
	end

	def verify_otp
    end

	def verified_otp
		user = User.find_by_mobile(session[:mobile])
		if user.valid_password?(params[:otp])
			sign_in_and_redirect_to_path(user)
		else
			flash[:alert]="You have entered wrong OTP information"
			redirect_to :back
		end
    end


	def resend_otp
		if session[:mobile].present?
			user = User.find_by_mobile(session[:mobile])
			user.update_new_password_and_send_otp
		end
		flash[:success]="We have resend your OTP at "+session[:mobile]
		redirect_to :back
    end

    private

    def sign_in_and_redirect_to_path(user)
    	sign_in(:user, user)
    	redirect_to update_information_path
    end    
end
