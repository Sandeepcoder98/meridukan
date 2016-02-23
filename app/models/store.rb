class Store < ActiveRecord::Base
  # after_save :update_lat_long
  belongs_to :user
  has_many :products
  
  include LatLng

  # Setting Up Objects  
  searchable do
    text :name
    text :city
    text :state
    text :landmark
    text :address
    text :pin_code
    text :user do
      user.try(:first_name)
      user.try(:last_name)
    end
  end
  
  def full_address
    "#{name}, #{address}, #{city}, #{state}, #{pin_code}"
  end
end
