class SearchController < ApplicationController
    
  def index
    @q = params[:id]
    
    finder = nil
    
    finder = Boat.find_by_number(@q)
    
    unless finder.blank?
      redirect_to :controller => :boats, :action => :show, :year => 2009, :id => finder.number
    end
            
  end
  
end
