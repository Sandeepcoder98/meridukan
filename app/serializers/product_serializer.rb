class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :key_information, :delivery_time
  has_one :pricing
  has_one :price_offer
  has_one :product_offer 
  has_one :product_shipping_detail  
  has_one :pricing
  has_one :additional_offer
  has_many :galleries
end


