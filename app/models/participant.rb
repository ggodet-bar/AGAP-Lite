class Participant < ActiveRecord::Base
  belongs_to  :pattern_system
  
  validates_presence_of :name
  # has_many :process_patterns, :through  => :participations
  # has_many :participations
end
