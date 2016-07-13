class DashboardController < ApplicationController
	layout "seller_dashboard"
	before_action :authenticate_user!
	respond_to :json

	def manage_sales
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

	def inbox
	end

	def manage_request
	end

	def buyer_request
	end

	def account_action
		@account_action = 'active'
		@user = current_user
	end

	def update_password
		@user = User.find(current_user.id)
		if @user.update(user_params)
		  sign_in @user, :bypass => true
		  redirect_to root_path
		else
		  render "account_action"
		end
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

	def my_sellers

	end

	def edit_image
		store = current_user.store
		params[:logo] ? store.update_attributes(logo: params[:logo]) : store.update_attributes(cover: params[:banner])		
	end

	def edit_seller_iamge
		current_user.update_attributes(avatar: params[:avatar]) 
	end


	def my_buyers
		@sellers = OrderItem.joins(:product).where('products.store_id': current_user.store.id).map(&:order).map{ |order| order.user_id }.uniq.compact
	end

	private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end

end
