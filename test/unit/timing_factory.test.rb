require File.dirname(__FILE__) + '/../test_helper'

class TimingFactoryTest < ActiveSupport::TestCase
  
  test "listing refresh" do
    TimingFactory.refresh_listing_from_web
    assert true
  end
  
end