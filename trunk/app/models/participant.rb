class Participant < ActiveRecord::Base
  belongs_to  :pattern_system
  # has_many :process_patterns, :through  => :participations
  # has_many :participations
end
