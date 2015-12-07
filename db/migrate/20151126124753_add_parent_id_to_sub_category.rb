class AddParentIdToSubCategory < ActiveRecord::Migration
  def change
    add_column :sub_categories, :parent_id,:integer, index: true
  end
end
