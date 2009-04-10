class AdminController < ApplicationController
  
  before_filter :authenticate
  
  def index
    @senior_doubles = Boat.senior_doubles
    @endeavour = Boat.endeavour
    @junior_doubles = Boat.junior_doubles
    @vet_junior_doubles = Boat.vet_junior_doubles
    @senior_singles = Boat.senior_singles
    @total = Boat.all     
  end
  
  def refresh
    Boat.destroy_all
    Paddler.destroy_all
    PaddlerFactory.refresh_listing_from_web
    redirect_to :action => index
  end
  
end
