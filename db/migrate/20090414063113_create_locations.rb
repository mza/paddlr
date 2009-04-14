class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.timestamps
    end
    
    Location.create :name => "Devizes", :latitude => 51.355291, :longitude => -1.995821
    Location.create :name => "Pewsey", :latitude => 51.348587, :longitude => -1.774657
    Location.create :name => "Hungerford", :latitude => 51.416566, :longitude => -1.514515
    Location.create :name => "Newbury", :latitude => 51.402321, :longitude => -1.321420
    Location.create :name => "Aldermaston", :latitude =>  51.400277, :longitude => -1.136377
    Location.create :name => "Reading", :latitude => 51.459983, :longitude => -0.942839
    Location.create :name => "Marsh", :latitude => 0.0, :longitude => 0.0
    Location.create :name => "Marlow", :latitude => 51.564753, :longitude => -0.758754
    Location.create :name => "Bray", :latitude => 51.499794, :longitude => -0.681571
    Location.create :name => "Old Windsor", :latitude => 51.453739, :longitude => -0.574551
    Location.create :name => "Shepperton", :latitude => 51.382924, :longitude => -0.454516
    Location.create :name => "Teddington", :latitude => 51.437236, :longitude => -0.328367
    Location.create :name => "Westminster", :latitude => 51.500809, :longitude => -0.122008
    
    # Devizes:     51.355291, -1.995821
    # Pewsey:      51.348587, -1.774657
    # Hungerford:  51.416566, -1.514515
    # Newbury:     51.402321, -1.321420
    # Aldermaston: 51.400277, -1.136377
    # Reading:     51.459983, -0.942839
    # Marsh:       ?
    # Marlow:      51.564753, -0.758754
    # Bray:        51.499794, -0.681571
    # Old Windsor: 51.453739, -0.574551
    # Shepperton:  51.382924, -0.454516
    # Teddington:  51.437236, -0.328367
    # Westminster: 51.500809, -0.122008
    
    
  end

  def self.down
    drop_table :locations
  end
end
