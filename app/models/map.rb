class Map < ActiveRecord::Base
  has_one :process_pattern
  
  
  # t.integer  "mappable_image_id"
  # t.integer  "x_corner"
  # t.integer  "y_corner"
  # t.integer  "width"
  # t.integer  "height"
  # t.integer  "pattern_id"
end
