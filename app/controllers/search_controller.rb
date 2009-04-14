class SearchController < ApplicationController
  
  layout 'boats'
  
  def index
    if params[:q].nil?
      @q = params[:id]
    else
      @q = params[:q]
    end
        
    @boat = Boat.find_by_number(@q)    
    @paddlers = Paddler.find_by_name(@q)      
    @clubs = Paddler.find_all_by_club(@q).sort_by {|p| p.boat.result.time }
    
    unless @boat.nil?
      redirect_to :controller => :boats, :action => :show, :year => 2009, :id => @boat.number
    end
    
    if !@paddlers.nil? && @paddlers.size == 1
      redirect_to :controller => :boats, :action => :show, :year => 2009, :id => @paddlers.first.boat.number
    end
        
  end
  
end
