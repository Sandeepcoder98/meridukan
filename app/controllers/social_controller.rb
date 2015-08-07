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
			sign_in_and_redirect(user)
		else
			flash[:alert]="You have entered wrong otp information"
			redirect_to :back
		end
    end


	def resend_otp
		if session[:mobile].present?
			user = User.find_by_mobile(session[:mobile])
			user.update_new_password_and_send_otp
		end
		flash[:success]="We have resend your otp at "+session[:mobile]
		redirect_to :back
    end
end
