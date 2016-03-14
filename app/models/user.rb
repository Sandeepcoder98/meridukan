class User < ActiveRecord::Base
  rolify
  after_save :update_lat_long
  has_one :store
  has_many :products,:through=> :store
  accepts_nested_attributes_for :store, :reject_if => :all_blank
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Avatar uploader
  has_attached_file :avatar, :styles => { :small => "150x150>" }, :default_url => 'missing_avatar_:style.png'
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  belongs_to :product
  validates_presence_of   :mobile
  validates_uniqueness_of :mobile
  validates     :mobile, numericality: { only_integer: true }

  include LatLng

  def email_required?
  	false
  end

  def self.send_otp(password,mobile)
    mobile="+91#{mobile}"
    message = TwilioClient.account.messages.create({
      :from => '+12028998148', 
      :to => mobile, 
      :body => password,  
    }) rescue false
  end


  def self.generated_password
    generated_password = "12345678"
  end
  
  def update_new_password_and_send_otp
    password = User.generated_password
    User.send_otp(password,mobile)
    self.password=password
    self.save
  end

  def add_user_role(role)
    self.add_role(role)
  end

  # def set_user_info(user_info)
  #   self.city = user_info["city"] if self.city.blank?
  #   self.state = user_info["regionName"] if self.state.blank?
  #   self.pin_code = user_info["zip"] if self.pin_code.blank?
  #   self.save
  # end

  def seller?
    self.has_role? :seller    
  end

  def buyer?
    self.has_role? :buyer
  end

  def check_user_access?
    ((self.seller? && self.store.products.empty?)? true : false)
  end

  def full_address
    "#{address}, #{city}, #{state}, #{pin_code}"
  end
end
