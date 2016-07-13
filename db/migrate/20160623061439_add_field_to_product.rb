class AddFieldToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cancelled, :boolean
  end
end
