class AddKeyInformationToProducts < ActiveRecord::Migration
  def change
    add_column :products, :key_information, :string
  end
end
