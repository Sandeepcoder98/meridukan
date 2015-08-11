class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :country
      t.string :state
      t.string :city
      t.references :user
      
      t.timestamps null: false
    end
  end
end
