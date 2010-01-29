class ClassificationElement < ActiveRecord::Base
  belongs_to :pattern_system
  belongs_to :field_descriptor

  validates_presence_of :name


  def classification_type
    self.field_descriptor.field_type
  end
end
