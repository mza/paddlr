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
    cracknell_correction
    redirect_to :controller => :admin, :action => :index    
  end
  
  def correct
    cracknell_correction
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

    def cracknell_correction
      paddler = Paddler.find_by_first_name_and_surname("Cracknell", "James")
      paddler.first_name = "James"
      paddler.surname = "Cracknell"
      paddler.save
      
      paddler = Paddler.find_by_first_name_and_surname("Shrosbree", "Bernie")
      paddler.first_name = "Bernie"
      paddler.surname = "Shrosbree"
      paddler.save            
    end
    
  
end

