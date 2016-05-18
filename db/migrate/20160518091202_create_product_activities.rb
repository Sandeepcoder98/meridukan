class CreateProductActivities < ActiveRecord::Migration
  def change
    create_table :product_activities do |t|
      t.integer :product_id
      t.text 	:description
      t.string  :activity

      t.timestamps null: false
    end
  end
end
