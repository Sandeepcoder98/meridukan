class Store < ActiveRecord::Base
  # after_save :update_lat_long
  belongs_to :user
  has_many :products
  
  include LatLng

  def full_address
    "#{name}, #{address}, #{city}, #{state}, #{pin_code}"
  end
end
