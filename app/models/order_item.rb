class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  has_many :buyer
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present
  belongs_to :order_status
  before_create :set_order_status
  before_save :finalize

  default_scope { order('created_at DESC') }

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.net_mrp
    end
  end

  def total_price
    unit_price * quantity
  end

  def placed(buyer)
    self.update(order_status_id: 2)
    self.order.update(user_id: buyer.id)
    # self.send_placed_information(buyer)
  end

private

  def set_order_status
    self.order_status_id = 1
  end


  def product_present
    if product.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end