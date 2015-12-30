class CreateAdditionalOffers < ActiveRecord::Migration
  def change
    create_table :additional_offers do |t|
      t.string :offer_type
      t.integer :offer_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
