class AddMobileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :bigint
  end
end
