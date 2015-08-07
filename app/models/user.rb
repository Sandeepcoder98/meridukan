class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of   :mobile
  validates_uniqueness_of :mobile
  validates     :mobile, numericality: { only_integer: true }

  def email_required?
  	false
  end

  def self.send_otp(password,mobile)
    mobile="+91#{mobile}"
    message = TwilioClient.account.messages.create({
      :from => '+17548884078', 
      :to => mobile, 
      :body => password,  
    }) rescue false
  end


  def self.generated_password
    generated_password = Devise.friendly_token.first(8)
  end
  
  def update_new_password_and_send_otp
    password = User.generated_password
    User.send_otp(password,mobile)
    self.password=password
    self.save
  end
      
end
