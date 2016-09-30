class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :key_information, :delivery_time, :photo_url, :product_rating
  has_one :pricing
  has_one :price_offer
  has_one :product_offer 
  has_one :product_shipping_detail  
  has_one :pricing
  has_one :additional_offer
  has_many :galleries
  belongs_to :store
end


