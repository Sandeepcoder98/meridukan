class Store < ActiveRecord::Base
  after_save :update_lat_long
  before_save :store_state_and_city
  belongs_to :user
  has_many :products
  # Logo uploader
  has_attached_file :logo, :styles => { :small => "150x150>" }, :default_url => 'missing_logo_:style.jpg'
  validates_attachment_size :logo, :less_than => 5.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  # Cover uploader
  has_attached_file :cover, :styles => { :small => "150x150>" }, :default_url => 'missing_cover_:style.jpg'
  validates_attachment_content_type :cover, :content_type => ['image/jpeg', 'image/png']

  include UpdateStaticData

  # Setting Up Objects  
  searchable do
    integer :id
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
    latlon(:location) { Sunspot::Util::Coordinates.new(lat, lng) }
  end
  
  def full_address
    "#{name}, #{address}, #{city}, #{state}, #{pin_code}"
  end

  def logo_url
    "#{logo.path}" rescue ""
  end

  def cover_url
    "#{cover.path}" rescue ""
  end

  def store_rating
    rating.blank? ? "2" : "#{rating}"  rescue ""
  end

   def store_distance
    distance.blank? ? "2" : "#{distance}" rescue ""
  end

end
