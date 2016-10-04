class OrderSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :total_price, :order_status_id
  belongs_to :product
  belongs_to :order
end
