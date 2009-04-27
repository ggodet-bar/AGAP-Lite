class ImageAssociation < ActiveRecord::Base
  validates_presence_of :process_pattern_id, :mappable_image_id
  belongs_to  :process_pattern
  belongs_to  :mappable_image
end