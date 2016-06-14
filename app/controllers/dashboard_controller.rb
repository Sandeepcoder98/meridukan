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
		@products_approved_false = current_user.products.where(apply_approve: false)
		@products_approved = current_user.products.where(apply_approve: true)
		@products_denied = current_user.products.where(approve: false)
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
		@sellers = OrderItem.joins(:product).where('products.store_id': current_user.store.id) 
	end

	def my_buyers
		@sellers = OrderItem.joins(:product).where('products.store_id': current_user.store.id).map(&:order).map{ |order| order.user_id }.uniq.compact
	end
end
