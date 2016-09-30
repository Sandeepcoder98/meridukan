class AddRattingToStore < ActiveRecord::Migration
  def change
    add_column :stores, :rating, :float
    add_column :stores, :distance, :string
  end
end
