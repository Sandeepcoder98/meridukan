class Api::OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :quantity, :total_price
  #has_many :order_items
  belongs_to :product
  #belongs_to :order
end
