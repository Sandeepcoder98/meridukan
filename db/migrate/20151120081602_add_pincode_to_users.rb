class AddPincodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pin_code, :integer
  end
end
