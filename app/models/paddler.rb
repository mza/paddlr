class Paddler < ActiveRecord::Base
  belongs_to :boat
  
  def full_name
    "#{first_name} #{surname}"
  end
  
  def self.find_by_name(name)
    Paddler.all.select{ |p| p.full_name.downcase == name.downcase }
  end
  
  def club
    n = read_attribute(:club).split(/\s+/).each{ |word| word.capitalize! }.join(' ')
    n.gsub!(/Cc/, "CC")
    n
  end
  
end
