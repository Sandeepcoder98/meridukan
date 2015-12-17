module ProductsHelper
	def set_delivery_time
		(1..23).map{|time| ["#{time} Hour",time]}
	end

	def get_parent_category
		Category.all.map{|category| [category.title,category.id]}
	end

	def get_child_category
		SubCategory.where(:parent_id=>nil).map{|category| [category.title,category.id,:class=>category.category_id ]}
	end

	def get_sub_child_category
		SubCategory.where.not(:parent_id=>nil).map{|category| [category.title,category.id,:class=>category.parent_id]}
	end

	def get_id(parent,category)
		if category.parent_id.blank?
			category.category_id
		else
			category.parent_id
		end
	end

	def calculate_net_mrp(pricing)
		net_mrp = pricing.mrp_per_unit.to_f-pricing.offer_on_mrp.to_f rescue 0
		(net_mrp>0 ? net_mrp : 0).round(2) 
	end

	def offer_type
		[["Buy & Get","buy_get"],["Gift","gift"],[" Off on total purchase","total"] ]
	end

	def set_child_category(parent,category)
		SubCategory.where(:parent_id=>nil,:category_id=>category).map{|category| [category.title,category.id]} unless parent.blank?
	end

	# Method for prouct header active tab
	def product_active_tab(tab)
		tab.blank? ? "btn-default" : "btn-success"
	end
end
