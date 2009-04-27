class PatternSystem < ActiveRecord::Base
  has_many  :process_patterns, :dependent  => :destroy
  has_many  :product_patterns
  has_many  :participants, :dependent  => :destroy
  has_many  :mappable_images, :dependent => :destroy
  
  validates_presence_of :author, :name, :short_name
  validates_uniqueness_of :name
  validates_uniqueness_of :short_name
  
  def to_param
    "#{short_name}"
  end
  
end
