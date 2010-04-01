class AdminController < ApplicationController
  
  before_filter :authenticate
  
  def index
    @senior_doubles = Boat.senior_doubles
    @endeavour = Boat.endeavour
    @junior_doubles = Boat.junior_doubles
    @vet_junior_doubles = Boat.vet_junior_doubles
    @senior_singles = Boat.senior_singles
    @results = Result.all
    @total = Boat.all
  end
  
  def refresh
    clear_all
    PaddlerFactory.refresh_listing_from_web
    TimingFactory.refresh_listing_from_web    
    redirect_to :controller => :admin, :action => :index    
  end
    
  def clear
    clear_all
    redirect_to :controller => :admin, :action => :index    
  end

  private 
  
    def clear_all
      Boat.destroy_all
      Paddler.destroy_all     
      Timing.destroy_all 
      Result.destroy_all
    end    
  
end

