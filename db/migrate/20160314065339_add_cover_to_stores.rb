class AddCoverToStores < ActiveRecord::Migration
  def change
    add_attachment :stores, :cover
  end
end
