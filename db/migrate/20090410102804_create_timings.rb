class CreateTimings < ActiveRecord::Migration
  def self.up
    create_table :timings do |t|
      t.string :time
      t.string :notes
      t.string :location_id
      t.integer :boat_id
      t.timestamps
    end
  end

  def self.down
    drop_table :timings
  end
end
