class AddColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :status, :boolean, :default => false
    add_column :products, :step_path, :string
  end
end
