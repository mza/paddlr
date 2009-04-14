class Team
  
  attr_accessor :name
  
  def initialize(*args)
    options = args.extract_options!
    self.name = options[:name]
  end
  
  def name
    n = @name.split(/\s+/).each{ |word| word.capitalize! }.join(' ')
    n.gsub!(/Cc/, "CC")
    n
  end
  
  def paddlers
    Paddler.all.select { |p| p.club.downcase == @name.downcase }
  end
  
end
