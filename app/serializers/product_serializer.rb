class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :key_information, :delivery_time
end