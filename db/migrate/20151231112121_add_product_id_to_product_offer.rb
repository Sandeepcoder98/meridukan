class AddProductIdToProductOffer < ActiveRecord::Migration
  def change
    add_column :product_offers, :product_id, :integer
  end
end
