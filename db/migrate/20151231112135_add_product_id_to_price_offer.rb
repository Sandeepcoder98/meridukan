class AddProductIdToPriceOffer < ActiveRecord::Migration
  def change
    add_column :price_offers, :product_id, :integer
  end
end
