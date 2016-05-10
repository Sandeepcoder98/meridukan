class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.bigint :mobile
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :pin_code
      t.boolean :status, default: false
      t.integer :user_id
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lng, {:precision=>10, :scale=>6}

      t.timestamps null: false
    end
  end
end