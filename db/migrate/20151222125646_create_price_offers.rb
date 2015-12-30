class CreatePriceOffers < ActiveRecord::Migration
  def change
    create_table :price_offers do |t|
      t.decimal :percent
      t.decimal :amount
      t.string :gift

      t.timestamps null: false
    end
  end
end
