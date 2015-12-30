class CreateProductOffers < ActiveRecord::Migration
  def change
    create_table :product_offers do |t|
      t.integer :buy
      t.integer :get
      t.string :gift

      t.timestamps null: false
    end
  end
end
