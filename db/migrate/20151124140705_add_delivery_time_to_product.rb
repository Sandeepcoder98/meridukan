class AddDeliveryTimeToProduct < ActiveRecord::Migration
  def change
    add_column :products,:delivery_time,:integer 
  end
end
