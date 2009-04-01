class PatternSystem < ActiveRecord::Base
  has_many  :process_patterns, :dependent  => :destroy
  has_many  :product_patterns
  has_many  :participants, :dependent  => :destroy
  
end
