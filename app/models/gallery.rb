class Gallery < ActiveRecord::Base
	has_attached_file :photo, :styles => { :small => "150x150>" }, :default_url => '/assets/missing_photo_:style.png'
	validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
	belongs_to :product
end
