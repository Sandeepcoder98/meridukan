class AddIndexToMobile < ActiveRecord::Migration
  def change
	remove_index :users, :column=>:email
    add_index :users, :mobile, unique: true
  end
end
