class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.text :channel
      t.string :os

      t.timestamps null: false
    end
  end
end
