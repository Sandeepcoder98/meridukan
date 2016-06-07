class AddFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :current_lat, :decimal, {:precision=>10, :scale=>6}
    add_column :users, :current_lng, :decimal, {:precision=>10, :scale=>6}
    add_column :users, :device_type, :string
    add_column :users, :device_token, :text
  end
end
