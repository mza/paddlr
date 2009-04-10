class CreateTimings < ActiveRecord::Migration
  def self.up
    create_table :timings do |t|
      t.string :status
      t.string :elapsed_time
      t.string :time_today
      t.string :notes
      t.string :location
      t.integer :boat_id
      t.timestamps
    end
  end

  def self.down
    drop_table :timings
  end
end
