class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :boat_id
      t.string :time
      t.string :position
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
