class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.integer :product_id
      t.integer :stock_quantity
      t.float :mrp_per_unit
      t.float :offer_on_mrp

      t.timestamps null: false
    end
  end
end
