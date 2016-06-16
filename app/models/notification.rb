class Notification < ActiveRecord::Base

  has_many :buyer, class_name: "Notification", foreign_key: "buyer_id"
  has_many :seller, class_name: "Notification", foreign_key: "seller_id"
  belongs_to :order_item

  scope :seller_unread, -> { where( is_seller_read: false ) }
  scope :buyer_unread, -> { where( is_buyer_read: false ) }
  default_scope { order(created_at: :desc) }

  def seller_read
    is_seller_read ? 'read' : ''
  end

  def buyer_read
    is_buyer_read ? 'read' : ''
  end
end
