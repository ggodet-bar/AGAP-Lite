class ClassificationSelection < ActiveRecord::Base
  belongs_to  :pattern
  belongs_to  :classification_element

  def field_descriptor
    self.classification_element.field_descriptor
  end
end
