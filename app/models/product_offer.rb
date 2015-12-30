class ProductOffer < ActiveRecord::Base
	has_one :addtional_offer, :as=>:offer
	accepts_nested_attributes_for :addtional_offer
end
