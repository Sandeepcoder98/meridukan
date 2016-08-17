class Api::V1::OrdersController < Api::AuthenticationController
  def index
	  @orders = OrderItem.joins(:product).where('products.store_id': current_user.store.id)
	  render :json => @orders
	end
end