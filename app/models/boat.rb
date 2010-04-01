class Boat < ActiveRecord::Base
  has_many :paddlers
  has_many :timings
  has_one :result
  
  named_scope :senior_doubles, :conditions => { :entered_in => "Senior doubles" }
  named_scope :endeavour, :conditions => { :entered_in => "Endeavour" }
  named_scope :junior_doubles, :conditions => { :entered_in => "Junior doubles" }
  named_scope :vet_junior_doubles, :conditions => { :entered_in => "Vet_Junior doubles" }
  named_scope :senior_singles, :conditions => { :entered_in => "Senior singles" }

  def position
    if self.result
      pos = self.result.position.to_i
      if pos == 0
        pos = 999
      end
    else
      post = 999
    end
    pos
  end

  def retired?
    if self.position.to_i == 999
      return true
    else
      return false
    end
  end
  
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
  
  def paddler_names_with_clubs(ampersand = "and")
    names = "#{self.paddlers.first.full_name} (#{self.paddlers.first.club})"
    if self.paddlers.size > 1
      names = "#{names} #{ampersand} #{self.paddlers.second.full_name} (#{self.paddlers.second.club})"
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

  def distance_times
    if self.timings.size > 13
      distance_times_for_four_days
    else
      distance_times_for_straight_through
    end
  end

  def distance_times_for_straight_through
    # Cumulative timings
    
    # 0: Devizes
    # 1: Pewsey
    # 2: Hungerford
    # 3: Newbury    
    # 4: Aldermaston
    # 5: Reading
    # 6: Marsh
    # 7: Marlow    
    # 8: Bray
    # 9: Old Windsor
    # 10: Shepperton
    # 11: Teddington
    # 12: Westminster
    
    stage_1 = time_between(self.timings[0].time, self.timings[1].time) 
    stage_2 = stage_1 + time_between(self.timings[1].time, self.timings[2].time) 
    stage_3 = stage_2 + time_between(self.timings[2].time, self.timings[3].time)   
    stage_4 = stage_3 + time_between(self.timings[3].time, self.timings[4].time) 
    stage_5 = stage_4 + time_between(self.timings[4].time, self.timings[5].time) 
    stage_6 = stage_5 + time_between(self.timings[5].time, self.timings[6].time) 
    stage_7 = stage_6 + time_between(self.timings[6].time, self.timings[7].time) 
    stage_8 = stage_7 + time_between(self.timings[7].time, self.timings[8].time)
    stage_9 = stage_8 + time_between(self.timings[8].time, self.timings[9].time) 
    stage_10 = stage_9 + time_between(self.timings[9].time, self.timings[10].time) 
    stage_11 = stage_10 + time_between(self.timings[10].time, self.timings[11].time)
    stage_12 = self.total_time_in_seconds
    
    "0,#{stage_1},#{stage_2},#{stage_3},#{stage_4},#{stage_5},#{stage_6},#{stage_7},#{stage_8},#{stage_9},#{stage_10},#{stage_11},#{stage_12}"
    
  end

  def distance_times_for_four_days
    
    # Cumulative timings
    
    # 0: Devizes
    # 1: Pewsey
    # 2: Hungerford
    # 3: Newbury (end)
    
    # 4: Newbury (start)
    # 5: Aldermaston
    # 6: Reading
    # 7: Marsh
    # 8: Marlow (end)
    
    # 9: Marlow (start)
    # 10: Bray
    # 11: Old Windsor
    # 12: Shepperton
    # 13: Teddington (end)
    # 14: Teddington (start)
    # 15: Westminster
    
    # Day 1
    stage_1 = time_between(self.timings[0].time, self.timings[1].time) # Devizes to Pewsey
    stage_2 = stage_1 + time_between(self.timings[1].time, self.timings[2].time) # Pewsey to Hungerford
    stage_3 = stage_2 + time_between(self.timings[2].time, self.timings[3].time) # Hungerford to Newbury
    
    # Day 2
    stage_4 = stage_3 + time_between(self.timings[4].time, self.timings[5].time) # Newbury to Aldermaston
    stage_5 = stage_4 + time_between(self.timings[5].time, self.timings[6].time) # Aldermaston to Reading
    stage_6 = stage_5 + time_between(self.timings[6].time, self.timings[7].time) # Reading to Marsh
    stage_7 = stage_6 + time_between(self.timings[7].time, self.timings[8].time) # Marsh to Marlow
    
    # Day 3
    stage_8 = stage_7 + time_between(self.timings[9].time, self.timings[10].time) # Marlow to Bray
    stage_9 = stage_8 + time_between(self.timings[10].time, self.timings[11].time) # Bray to Old Windsor
    stage_10 = stage_9 + time_between(self.timings[11].time, self.timings[12].time) # Old Windsor to Shepperton
    stage_11 = stage_10 + time_between(self.timings[12].time, self.timings[13].time) # Shepperton to Teddington
    
    # Day 4
    stage_12 = self.total_time_in_seconds # Teddington to Wesminster
    
    "0,#{stage_1},#{stage_2},#{stage_3},#{stage_4},#{stage_5},#{stage_6},#{stage_7},#{stage_8},#{stage_9},#{stage_10},#{stage_11},#{stage_12}"
  end

  def average_speed
    seconds = total_time_in_seconds
    per_second = 125 / seconds
    per_minute = per_second * 60
    per_hour = per_minute * 60
    
    '%.3f' % per_hour
  end
  
  def total_time_in_seconds
    time_to_seconds(self.result.time)
  end
  
  def time_to_seconds(time)
    time = time.gsub(/Fri|Sat|Sun|Mon| /, "")
    times = time.split(/\:/)
    seconds = times.third.to_f
    seconds += times.second.to_f * 60
    seconds += times.first.to_f * (60 * 60)
    seconds
  end
  
  def time_between(start_time, end_time)
    start_seconds = time_to_seconds(start_time)
    end_seconds = time_to_seconds(end_time)
    
    start_day = start_time.split(" ").first
    end_day = end_time.split(" ").first
    
    if start_day != end_day
      end_seconds = end_seconds + (60 * 60 * 24)
    end
        
    total = end_seconds - start_seconds
    total
  end
    
end
