module ProductsHelper
	def set_delivery_time
		(1..23).map{|time| ["#{time} Hour",time]}
	end

	def get_parent_category
		Category.all.map{|category| [category.title,category.id]}
	end

	def get_child_category
		SubCategory.all.map{|category| [category.title,category.id,:class=>get_id(category.parent_id,category.category_id) ]}
	end

	def get_id(parent,category)
		parent ||=category
	end

	def calculate_net_mrp(product)
		net_mrp = product.pricing.mrp_per_unit-product.pricing.offer_on_mrp rescue 0
		(net_mrp>0 ? net_mrp : 0) 
	end

	def offer_type
		[["Buy & Get","buy_get"],["Gift","gift"],[" Off on total purchase","total"] ]
	end

end
