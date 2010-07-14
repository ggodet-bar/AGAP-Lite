class ImageAssociation < ActiveRecord::Base
  # validates_presence_of :pattern_id #, :mappable_image_id
  belongs_to  :pattern
  belongs_to  :mappable_image
  accepts_nested_attributes_for :mappable_image, :reject_if => lambda {|a| a[:image_file_name].blank?}
  belongs_to  :field_descriptor
  has_many :maps
  accepts_nested_attributes_for :maps, :reject_if => lambda {|a| a[:relation_id].blank?}

end
