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
end
