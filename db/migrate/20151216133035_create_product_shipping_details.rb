class CreateProductShippingDetails < ActiveRecord::Migration
  def change
    create_table :product_shipping_details do |t|
      t.boolean :free_delivery
      t.integer :free_kilometers
      t.float :charge_per_kilometer
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_shipping_details, :products
  end
end
