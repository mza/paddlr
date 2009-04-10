class Boat < ActiveRecord::Base
  has_many :paddlers
  
  named_scope :senior_doubles, :conditions => { :entered_in => "Senior doubles" }
  named_scope :endeavour, :conditions => { :entered_in => "Endeavour" }
  named_scope :junior_doubles, :conditions => { :entered_in => "Junior doubles" }
  named_scope :vet_junior_doubles, :conditions => { :entered_in => "Vet_Junior doubles" }
  named_scope :senior_singles, :conditions => { :entered_in => "Senior singles" }
  
end
