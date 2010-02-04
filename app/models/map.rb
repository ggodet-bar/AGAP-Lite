class Map < ActiveRecord::Base
  has_one :target_pattern, :class_name => :pattern
  belongs_to :pattern
  belongs_to :mappable_image
  belongs_to :relation
end
