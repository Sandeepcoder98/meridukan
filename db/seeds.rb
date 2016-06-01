seed_file = Rails.root.join('db', 'seeds', 'categories.yml')
config = YAML::load_file(seed_file)

# creating parent Categories
	config.each do |title,value|
		Category.create({:title=> title})
		unless value.blank? 
			# creating sub categories
			value.each do |sub_key1,sub_value1|
				SubCategory.create({:title=> sub_key1,:category_id=> Category.where({:title=>title}).first.id})
					unless sub_value1.blank?
						sub_value1.each do |sub_key2,sub_value2|
							SubCategory.create({:title=> sub_key2,:parent_id=> SubCategory.where({:title=>sub_key1}).first.id,:category_id=> Category.where({:title=>title}).first.id})
						end
				  end
			end
	  end
	end


OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
# OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 3, name: "Delivered"
OrderStatus.create! id: 4, name: "Cancelled"

