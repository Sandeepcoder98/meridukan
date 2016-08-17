class Api::V1::OrderItemsController < Api::AuthenticationController
	before_action :add_item, only: [:create]
	before_action :current_order, only: [:create]
	
  respond_to :json
  def create

  end

  private

  	def add_item
	    @order = current_order
	    @order_item = @order.save_order_item(order_item_params)
	    @order.save
	    session[:order_id] = @order.id
	    render :json=> { status: true, message: 'add product to cart successfully' }, :status=>201
	  end

	  def current_order
	    begin
	      if !session[:order_id].nil?
	        Order.find(session[:order_id])
	      else
	        Order.new
	      end
	    rescue
	      Order.new
	    end
	  end

	  def order_item_params
	    params.require(:order_item).permit(:quantity, :product_id)
	  end
end

