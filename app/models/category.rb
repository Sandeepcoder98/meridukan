class Category < ActiveRecord::Base
	has_many :products
	has_many :sub_categories, :autosave => true
	accepts_nested_attributes_for :sub_categories, :reject_if => :all_blank
end
