class CreatePaddlers < ActiveRecord::Migration
  def self.up
    create_table :paddlers do |t|
      t.string :surname
      t.string :first_name
      t.string :gender
      t.string :club
      t.integer :position
      t.integer :boat_id
      t.timestamps
    end
  end

  def self.down
    drop_table :paddlers
  end
end
