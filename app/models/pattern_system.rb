class PatternSystem < ActiveRecord::Base
  has_many  :process_patterns
  has_many  :product_patterns
  has_many  :participants
end
