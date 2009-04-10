require File.dirname(__FILE__) + '/../test_helper'

class PaddlerFactoryTest < ActiveSupport::TestCase
  
  test "listing refresh" do
    file_path = File.dirname(__FILE__) + "/../files"
    boats = PaddlerFactory.refresh_listing_from_file("#{file_path}/all.html")
    assert_equal 346, boats.size
  end
  
  test "listing has created valid entries from web download" do
    boats = PaddlerFactory.refresh_listing_from_web
    boat = Boat.find_by_number(305)
    assert_kind_of Boat, boat
    assert_equal 2, boat.paddlers.size
    assert_kind_of Paddler, boat.paddlers.first
    
    first_paddler = boat.paddlers.first
    second_paddler = boat.paddlers.second
    
    assert_equal "Christopher", first_paddler.first_name
    assert_equal "Grundberg", first_paddler.surname
    assert_equal "Male", first_paddler.gender
    assert_equal "Independent", first_paddler.club
    
    assert_equal "Ross", second_paddler.first_name    
    assert_equal "Lovell", second_paddler.surname
    assert_equal "Male", second_paddler.gender
    assert_equal "Independent", second_paddler.club    
  end
  
    
  test "listing has created valid entries" do
    file_path = File.dirname(__FILE__) + "/../files"
    boats = PaddlerFactory.refresh_listing_from_file("#{file_path}/all.html")
    boat = Boat.find_by_number(305)
    assert_kind_of Boat, boat
    assert_equal 2, boat.paddlers.size
    assert_kind_of Paddler, boat.paddlers.first
    
    first_paddler = boat.paddlers.first
    second_paddler = boat.paddlers.second
    
    assert_equal "Christopher", first_paddler.first_name
    assert_equal "Grundberg", first_paddler.surname
    assert_equal "Male", first_paddler.gender
    assert_equal "Independent", first_paddler.club
    
    assert_equal "Ross", second_paddler.first_name    
    assert_equal "Lovell", second_paddler.surname
    assert_equal "Male", second_paddler.gender
    assert_equal "Independent", second_paddler.club    
  end
  
  test "listing has created entries in correct classes (and named scopes!)" do
    file_path = File.dirname(__FILE__) + "/../files"
    boats = PaddlerFactory.refresh_listing_from_file("#{file_path}/all.html")
    assert_equal 178, Boat.senior_doubles.size
    assert_equal 28, Boat.endeavour.size
    assert_equal 78, Boat.junior_doubles.size
    assert_equal 14, Boat.vet_junior_doubles.size
    assert_equal 48, Boat.senior_singles.size    
  end
  
  test "listing has created paddlers from different clubs" do
    file_path = File.dirname(__FILE__) + "/../files"
    boats = PaddlerFactory.refresh_listing_from_file("#{file_path}/all.html")
    boat = Boat.find_by_number(350)
    
    first_paddler = boat.paddlers.first
    second_paddler = boat.paddlers.second
    
    assert_equal "Peter", first_paddler.first_name
    assert_equal "Hurry", first_paddler.surname
    assert_equal "Male", first_paddler.gender
    assert_equal "SUFFOLK CONSTABULARY", first_paddler.club
    
    assert_equal "Steve", second_paddler.first_name    
    assert_equal "Foster", second_paddler.surname
    assert_equal "Male", second_paddler.gender
    assert_equal "CIVIL NUCLEAR CONSTABULARY", second_paddler.club
  end
  
end
