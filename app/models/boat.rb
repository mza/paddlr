class Boat < ActiveRecord::Base
  has_many :paddlers
  has_many :timings
  
  named_scope :senior_doubles, :conditions => { :entered_in => "Senior doubles" }
  named_scope :endeavour, :conditions => { :entered_in => "Endeavour" }
  named_scope :junior_doubles, :conditions => { :entered_in => "Junior doubles" }
  named_scope :vet_junior_doubles, :conditions => { :entered_in => "Vet_Junior doubles" }
  named_scope :senior_singles, :conditions => { :entered_in => "Senior singles" }

  def timings_for_location(location)
    timings.select {|t| t.location == location }
  end
  
  def paddler_names(ampersand = "and")
    names = self.paddlers.first.full_name
    if self.paddlers.size > 1
      names = "#{names} #{ampersand} #{self.paddlers.second.full_name}"
    end
    names
  end
  
  def classification
    classification = self.entered_in
    if classification == "Vet_Junior doubles"
      classification = "Junior / Veteran doubles"
    end
    classification
  end
  
end
