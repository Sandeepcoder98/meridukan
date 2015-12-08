class AddPublishToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :publish, :boolean, :default => false
  end
end
