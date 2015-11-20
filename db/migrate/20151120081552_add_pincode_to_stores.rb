class AddPincodeToStores < ActiveRecord::Migration
  def change
    add_column :stores, :pin_code, :integer
  end
end
