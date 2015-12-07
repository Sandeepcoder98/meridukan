class SubCategory < ActiveRecord::Base
	belongs_to :category
	belongs_to :parent_category, :class_name => 'SubCategory', :foreign_key => :parent_id
	has_many :child_categories, :class_name => 'SubCategory', :foreign_key => :parent_id
end
