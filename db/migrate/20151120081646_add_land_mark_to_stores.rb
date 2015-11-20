class AddLandMarkToStores < ActiveRecord::Migration
  def change
    add_column :stores, :landmark, :string
  end
end
