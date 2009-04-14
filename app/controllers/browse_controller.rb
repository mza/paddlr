class BrowseController < ApplicationController
  
  layout "boats"
  
  def classes    
    redirect_to :action => :show, :id => "senior_doubles"
  end
  
  def show
    type = params[:id]
    
    @boats = []
    
    case type
      when "senior_doubles": @boats = Boat.senior_doubles; @title = "Senior doubles"
      when "senior_singles": @boats = Boat.senior_singles; @title = "Senior singles"
      when "junior_doubles": @boats = Boat.junior_doubles.sort_by {|b| b.position }; @title = "Junior doubles"
      when "junior_vet": @boats = Boat.vet_junior_doubles; @title = "Junior / Veteran doubles"
      when "endeavour": @boats = Boat.endeavour; @title = "Endeavour"
    end
    
  end
    
  def year
  end
  
  def team
  end
  
end
