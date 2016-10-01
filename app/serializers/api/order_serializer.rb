class Api::OrderSerializer < ActiveModel::Serializer
  attributes :id, :subtotal
  has_many :order_items
  #belongs_to :product
  #belongs_to :order
end
