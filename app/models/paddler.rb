class Paddler < ActiveRecord::Base
  belongs_to :boat
  
  def full_name
    "#{first_name} #{surname}"
  end
  
end
