class AddChoiceTypeToPriceOffers < ActiveRecord::Migration
  def change
    add_column :price_offers, :choice_type, :integer
  end
end
