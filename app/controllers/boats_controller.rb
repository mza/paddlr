class BoatsController < ApplicationController
  
  def show
    @boat = Boat.find_by_number(params[:id])
  end
  
end
