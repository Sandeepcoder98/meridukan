class OrdersController < ApplicationController
  before_action :set_product, only: :view_product
  respond_to :json

  def view_product
    respond_with @product.decorate.view_product
  end
  
  def add_to_card
  	render nothing: true
  end

  private 
  
  def set_product
    @product = Product.find(params[:product_id])
  end
end
