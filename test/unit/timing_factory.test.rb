require File.dirname(__FILE__) + '/../test_helper'

class TimingFactoryTest < ActiveSupport::TestCase
  
  setup do
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
    PaddlerFactory.refresh_listing_from_web  
    TimingFactory.refresh_listing_from_web
  end
  
  test "listing refresh" do
    timings = Timing.all
    assert_equal 2672, timings.size
  end
  
  test "listing correctly assigns times to boats" do
    # 0: 51
    # 1: Westminster Mon 08:18:41
    # 2: 18:17:58
    # 3: 01:45:41
    # 4: 
    # 5: Fri 10:03:00
    # 6: Fri 11:55:00
    # 7: Fri 14:20:00
    # 8: Fri 15:44:01
    # 9: Sat 09:10:00
    # 10: Sat 10:37:00
    # 11: Sat 12:14:00
    # 12: Sat 13:14:00
    # 13: Sat 14:37:46
    # 14: Sun 09:10:00
    # 15: Sun 10:16:00
    # 16: Sun 11:32:05
    # 17: Sun 12:52:00
    # 18: Sun 14:33:30
    # 19: Mon 06:33:00
    # 20: Mon 08:18:41
    
    boat = Boat.find_by_number "51"
    assert_not_nil boat
    assert_equal 16, boat.timings.size
    assert_equal "Mon 08:18:41", boat.timings.last.time
  end
  
end
