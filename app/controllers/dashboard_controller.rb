class DashboardController < ApplicationController
	layout "seller_dashboard"
	#before_action :authenticate_user!
	respond_to :json

	def manage_sales
		@orders = OrderItem.joins(:product).where('products.store_id': current_user.store.id)
			@orders = get_orders_by_time if params[:search_date].present?
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
	end

	def analytics
	end

	def my_shop
		@store = current_user.store
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

	def edit_image
		store = current_user.store
		params[:logo] ? store.update_attributes(logo: params[:logo]) : store.update_attributes(cover: params[:banner])		
	end


	def my_buyers
		@sellers = OrderItem.joins(:product).where('products.store_id': current_user.store.id).map(&:order).map{ |order| order.user_id }.uniq.compact
	end
end
