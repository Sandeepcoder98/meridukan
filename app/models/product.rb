class Product < ActiveRecord::Base
	acts_as_taggable
	has_many :galleries
	has_one :product_shipping_detail	
	has_one :pricing
	belongs_to :category
	belongs_to :sub_category
	belongs_to :store
	accepts_nested_attributes_for :galleries, :reject_if => :all_blank
	accepts_nested_attributes_for :product_shipping_detail
	accepts_nested_attributes_for :pricing
	acts_as_taggable_on :name

	validates :title,:description,:delivery_time,:category_id,:galleries,:presence=>true


	def net_mrp
		net_mrp = pricing.mrp_per_unit.to_f-pricing.offer_on_mrp.to_f rescue 0
		(net_mrp>0 ? net_mrp : 0).round(2) 
	end
end
