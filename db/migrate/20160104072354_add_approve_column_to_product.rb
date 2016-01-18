class AddApproveColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :approve, :boolean, :default => false
  end
end
