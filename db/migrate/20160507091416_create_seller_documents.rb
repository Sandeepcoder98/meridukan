class CreateSellerDocuments < ActiveRecord::Migration
  def change
    create_table :seller_documents do |t|
      t.string :business_name
      t.string :business_type
      t.string :pan_card_number
      t.string :vat_card_number
      t.string :tan_card_number
      t.string :account_name
      t.string :account_number
      t.string :bank_name
      t.string :state
      t.string :city
      t.string :bank_branch
      t.string :ifsc_code
      t.string :address_proof
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
