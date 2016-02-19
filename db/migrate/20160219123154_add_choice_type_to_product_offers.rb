class AddChoiceTypeToProductOffers < ActiveRecord::Migration
  def change
    add_column :product_offers, :choice_type, :integer
  end
end
