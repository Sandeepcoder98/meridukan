class Product < ActiveRecord::Base
	acts_as_taggable
	has_many :galleries
	belongs_to :category
	belongs_to :sub_category
	belongs_to :store
	accepts_nested_attributes_for :galleries, :reject_if => :all_blank
	has_one :pricing
	acts_as_taggable_on :name
end
