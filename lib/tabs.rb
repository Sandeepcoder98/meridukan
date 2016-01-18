class Tabs
	# Method for prouct header active tab
	def self.next_product_tab(referrer_action)
		{"new"=>"pricing", "edit"=>"pricing","pricing"=>"additional_offers","additional_offers"=>"shipping_details","shipping_details"=>"publish","publish"=>"edit"}[referrer_action]
	end
end