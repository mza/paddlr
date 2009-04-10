class CreateBoats < ActiveRecord::Migration
  def self.up
    create_table :boats do |t|
      t.integer :number
      t.string :entered_in
      t.timestamps
    end
  end

  def self.down
    drop_table :boats
  end
end
