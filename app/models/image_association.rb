class ImageAssociation < ActiveRecord::Base
  validates_presence_of :pattern_id, :mappable_image_id
  belongs_to  :pattern
  belongs_to  :mappable_image
end
