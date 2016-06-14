class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :order_item_id
      t.integer :order_id
      t.boolean :is_seller_read, default: false
      t.boolean :is_buyer_read, default: false
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
