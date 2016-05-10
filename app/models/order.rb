class Order < ActiveRecord::Base
  belongs_to :order_status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def placed(buyer)
    self.update(order_status_id: 2, user_id: buyer.id)
    self.send_placed_information(buyer)
  end

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def latest_items
    order_items.take(2)
  end

  def save_order_item(order_item_params)
    order_item = order_items.find_or_initialize_by(product_id: order_item_params[:product_id])
    total_quantity = order_item.quantity.to_i+order_item_params[:quantity].to_i
    available_quantity = order_item.product.pricing.stock_quantity
    return false if available_quantity < total_quantity
    order_item.quantity = order_item.quantity.to_i + order_item_params[:quantity].to_i
    order_item.save
    order_item
  end

  def update_order_item(order_item_id, order_item_params)
    order_item = order_items.find(order_item_id)
    total_quantity = order_item_params[:quantity].to_i
    available_quantity = order_item.product.pricing.stock_quantity
    return false if available_quantity < total_quantity
    order_item.update_attributes(order_item_params)
    order_item
  end

  def send_placed_information(buyer)
    sellers = User.joins(:store).joins(:products).where('products.id'=>order_items.map(&:product_id))
    sellers.send_information_to_sellers(self)
    buyer.send_information_to_buyer(self)
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end