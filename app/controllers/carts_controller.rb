class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def checkout
  end

  def destroy
  	current_order.order_items.destroy_all
  	redirect_to :back
  end
end
