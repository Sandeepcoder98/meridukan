class AddBuyForGiftToProductOffers < ActiveRecord::Migration
  def change
    add_column :product_offers, :buy_for_gift, :float
  end
end
