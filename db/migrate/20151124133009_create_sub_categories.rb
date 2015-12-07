class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.text :title
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
