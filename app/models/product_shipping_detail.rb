class ProductShippingDetail < ActiveRecord::Base
  after_save :update_free_delivery
  belongs_to :product

  def update_free_delivery
  	update_column("free_delivery", true)
  end
end
