class SocialController < ApplicationController
	layout "members"
	helper_method :get_ip_info
	def signup
	end

	def main
	end

	def verify_otp

    end

	def verified_otp
		user = User.find_by_mobile(session[:mobile])
		if user.valid_password?(params[:otp])
			get_ip_info(user)
			sign_in_and_redirect(user)
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
    
end
