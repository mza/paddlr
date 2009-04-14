class BoatsController < ApplicationController
  
  def show
    @boat = Boat.find_by_number(params[:id])
    
    @map = GMap.new("map_div_id")  
    @map.control_init(:large_map => true, :map_type => true)  
    @map.center_zoom_init([ 51.459983,-0.942839], 8)
    @info = ""
    previous_location = nil
    
    @boat.timings.each do |timing|      
      location = timing.location
      if location.latitude != 0.0
        
        if location == previous_location
          @info = "#{@info}<br />#{timing.time}"
        else
          @info = "#{location.name}<br />#{timing.time}"
        end
        
        marker = GMarker.new([location.latitude, location.longitude], :title => location.name, :info_window => @info)  
        @map.overlay_init(marker)          
        
      end
      previous_location = location
    end
        
  end
  
end
