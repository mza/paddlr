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
    timing = nil
    doc.each do |line|
      if line.match /^FourDayPs/
        details = line.split("=")
        value = details.last.gsub(/'|;/, "")
        prefix = details.first.split("[")
        key = prefix.last.gsub(/\]/, "")
        
        unless key == "i"
          
          if key == "0"
            timing = Timing.new
          end
          
          puts "#{key}: #{value}"
        end
      end
    end
  end
  
  def self.property(key)
    if @@properties.nil?
      properties = { :0 => "boat_id" }
    end
    properties[key.to_sym]
  end
  
end