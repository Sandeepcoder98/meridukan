class User < ActiveRecord::Base
  rolify
  after_save :update_lat_long
  before_save :store_state_and_city
  has_one :store
  has_many :products,:through=> :store
  has_many :shipping_addresses
  accepts_nested_attributes_for :store, :reject_if => :all_blank
  acts_as_token_authenticatable
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

  include UpdateStaticData

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

  def self.find_and_assign_form(mobile)
    user = find_by_mobile mobile
    user_checkout_auth(user, mobile)
  end

  def self.new_user(mobile)
    user = User.new(mobile: mobile)
    user.add_role_and_send_otp
    user
  end

  def self.user_checkout_auth(user, mobile)
    user.nil? ? [new_user(mobile), "sign_up_form"] : [user, "sign_in_form"]
  end

  def add_role_and_send_otp
    add_user_role "buyer"
    update_new_password_and_send_otp
  end

  def self.send_information_to_sellers(order)
    self.all.each do |seller|
      MessagingService.new(:mobile => seller.mobile, :message => "New order request #{order.id} and amount is #{order.subtotal.to_f}").send_message
    end
  end

  def send_information_to_buyer(order)
    MessagingService.new(:mobile => mobile, :message => "We have received your order #{order.id} and amount is #{order.subtotal.to_f}").send_message
  end

  def set_default_address shipping_address_id
    shipping_addresses.update_all(status: false)
    shipping_addresses.find(shipping_address_id).update(status: true)
  end
end