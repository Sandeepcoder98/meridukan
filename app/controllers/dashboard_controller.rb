class DashboardController < ApplicationController
	layout "seller_dashboard"
	#before_action :authenticate_user!

	def manage_sales
	end

	def inbox
	end

	def manage_request
	end

	def buyer_request
	end

	def my_products
	end

	def analytics
	end

	def public_profile_setting
		@public_profile_setting = 'active'
	end

	def account_setting
		@account_setting = 'active'
	end

	def account_action
		@account_action = 'active'
	end

	def my_sellers
	end

	def my_buyers
	end
end
