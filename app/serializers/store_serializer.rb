class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :state, :city, :pin_code, :landmark, :logo, :cover
  has_many :products
end