class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :state, :city, :pin_code, :landmark, :logo_url, :cover_url, :store_rating, :store_distance
  has_many :products
end