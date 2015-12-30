class Product < ActiveRecord::Base
	acts_as_taggable
	has_many :galleries
	has_one :product_shipping_detail	
	has_one :pricing
	has_one :additional_offer
	belongs_to :category
	belongs_to :sub_category
	belongs_to :store
	has_one :product_offer, :through => :additional_offer, :source => :offer, :source_type => "ProductOffer"
	has_one :price_offer, :through => :additional_offer, :source => :offer, :source_type => "PriceOffer"
	accepts_nested_attributes_for :galleries, :reject_if => :all_blank
	accepts_nested_attributes_for :product_shipping_detail
	accepts_nested_attributes_for :pricing
	accepts_nested_attributes_for :additional_offer
	acts_as_taggable_on :name

	validates :title,:description,:delivery_time,:category_id,:galleries,:presence=>true


	def net_mrp
		net_mrp = pricing.mrp_per_unit.to_f-pricing.offer_on_mrp.to_f rescue 0
		(net_mrp>0 ? net_mrp : 0).round(2) 
	end
end
