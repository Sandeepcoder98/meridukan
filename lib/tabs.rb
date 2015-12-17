class Tabs
	# Method for prouct header active tab
	def self.next_product_tab(referrer_action)
		{"new"=>"pricing", "edit"=>"pricing","pricing"=>"shipping_details","shipping_details"=>"publish","publish"=>"publish"}[referrer_action]
	end
end