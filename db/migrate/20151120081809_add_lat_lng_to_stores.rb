class AddLatLngToStores < ActiveRecord::Migration
  def change
    add_column :stores, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :stores, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end