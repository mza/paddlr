class SearchController < ApplicationController
    
  def index
    @q = params[:q]
    
    finder = nil
    
    finder = Boat.find_by_number(@q)
    unless finder.blank?
      if finder.class == Boat
        redirect_to :controller => :boats, :action => :show, :year => 2009, :id => finder.number
      end
    end
            
  end
  
end
