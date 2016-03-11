class OrderItemsController < ApplicationController
  before_action :add_item, only: [:create, :quick_add]

  def create
  end

  def quick_add
  end

  def update
    @order = current_order
    @order_item = @order.update_order_item(params[:id], order_item_params)
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end

  def add_item
    @order = current_order
    @order_item = @order.save_order_item(order_item_params)
    @order.save
    session[:order_id] = @order.id
  end
end
