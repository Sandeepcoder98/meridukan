class AddChildSubCategoryIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :child_sub_category_id, :integer
  end
end
