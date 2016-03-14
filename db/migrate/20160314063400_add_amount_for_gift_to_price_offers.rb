class AddAmountForGiftToPriceOffers < ActiveRecord::Migration
  def change
    add_column :price_offers, :amount_for_gift, :float
  end
end
