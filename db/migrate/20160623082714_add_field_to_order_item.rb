class AddFieldToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :order_status_id, :integer
  end
end
