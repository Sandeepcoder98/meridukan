class OrdersController < ApplicationController

  	def index
	  	@orders = OrderItem.joins(:product).where('products.store_id': current_user.store.id)
			@orders = get_orders_by_time if params[:search_date].present?
	end

	def get_orders_by_time
		from_date = case
			when params[:search_date] == "Today"
				Date.today
			when params[:search_date] == "This Week"
				Date.today-7.days
			when params[:search_date] == "1 Month Ago"
				Date.today - 1.month
			when params[:search_date] == "2 Month Ago"
				Date.today - 2.month
			when params[:search_date] == "3 Month Ago"
				Date.today - 3.month
			when params[:search_date] == "All"
				Date.today - 10.year		
			end
		to_date = Time.now

		@orders.where('created_at': from_date...to_date)
	end
end
