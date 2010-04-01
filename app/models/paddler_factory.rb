class PaddlerFactory 
  
  require 'hpricot'
  require 'open-uri'

  def self.refresh_listing_from_web
    url = "http://www.dwrace.org.uk/results/2010/Results/OverallClassResults.html" # with results
    url = "http://dwrace.org.uk/results/2010/Results/OverallClassList.html" # team listing only
    doc = Hpricot(open(url))
    refresh_listing :xml => doc
  end
    
  def self.refresh_listing_from_file(filename)
    doc = open(filename) { |f| Hpricot(f) }
    refresh_listing :xml => doc
  end
  
  def self.refresh_listing(*args)
    options = args.extract_options!    
    doc = options[:xml]
    
    boats = []
    boat = nil
    entry_class = nil
    
    (doc / "//a").each do |element|
      unless element[:name].blank?
        entry_class = element[:name]
        (element/"tr").each do |row|
          paddler_details = row.search("td")
          if paddler_details.any?
            
            boat_number = paddler_details.first.at("b").inner_html
            time = paddler_details[7].inner_html
            position = paddler_details[8].inner_html
            
            if boat_number != "&nbsp"
              boat = Boat.create :number => boat_number, :entered_in => entry_class
              boats << boat
              
              unless position.empty?
                result = Result.new :position => position, :time => time
                result.boat = boat
                result.save
              end
              
            end
            
            surname = paddler_details.second.inner_html          
            first_name = paddler_details.third.inner_html
            gender = paddler_details.fourth.inner_html
            club = paddler_details.fifth.inner_html
                        
            paddler = Paddler.new :surname => surname, :first_name => first_name, :gender => gender, :club => club
            paddler.boat = boat
            paddler.save
            
          end
        end
      end
    end
    
    boats
  end
  
end
