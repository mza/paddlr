class TimingFactory
  
  require 'open-uri'

  @@properties = nil
  
  def self.refresh_listing_from_web
    url = "http://www.dwrace.org.uk/results/2009/Progress/FourDayPs.js"
    doc = open(url)
    refresh_listing :js => doc
  end
  
  def self.refresh_listing(*args)
    options = args.extract_options!    
    doc = options[:js]
    @boat = nil
    doc.each do |line|
      if line.match /^FourDayPs/
        details = line.split("=")
        value = details.last.gsub(/'|;/, "")
        prefix = details.first.split("[")
        key = prefix.last.gsub(/\]/, "")
        
        unless key == "i"
          
          if key == "0"
            @boat  = Boat.find_by_number value
          end          
          
          unless @boat.nil?
                        
            case key
              when "5": timing(:time => value, :location => "Devizes", :boat => @boat)
              when "6": timing(:time => value, :location => "Pewsey", :boat => @boat)
              when "7": timing(:time => value, :location => "Hungerford", :boat => @boat)
              when "8": timing(:time => value, :location => "Newbury", :boat => @boat)
              when "9": timing(:time => value, :location => "Newbury", :boat => @boat)
              when "10": timing(:time => value, :location => "Aldermaston", :boat => @boat)
              when "11": timing(:time => value, :location => "Reading", :boat => @boat)
              when "12": timing(:time => value, :location => "Marsh", :boat => @boat)              
              when "13": timing(:time => value, :location => "Marlow", :boat => @boat)              
              when "14": timing(:time => value, :location => "Marlow", :boat => @boat)              
              when "15": timing(:time => value, :location => "Bray", :boat => @boat)              
              when "16": timing(:time => value, :location => "Old Windsor", :boat => @boat)              
              when "17": timing(:time => value, :location => "Shepperton", :boat => @boat)              
              when "18": timing(:time => value, :location => "Teddington", :boat => @boat)              
              when "19": timing(:time => value, :location => "Teddington", :boat => @boat)              
              when "20": timing(:time => value, :location => "Westminster", :boat => @boat)                              
            end
            
          end
          
        end
      end
    end
  end
  
  def self.timing(*args)
    options = args.extract_options!    
    t = Timing.new
    t.time = options[:time].chomp
    t.location = Location.find_by_name(options[:location])
    t.boat = options[:boat]
    t.save
  end
    
end