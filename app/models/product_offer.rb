class ProductOffer < ActiveRecord::Base
	has_one :addtional_offer, :as=>:offer
	belongs_to :product
	accepts_nested_attributes_for :addtional_offer
end
