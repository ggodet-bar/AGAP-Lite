class ClassificationSelection < ActiveRecord::Base
  belongs_to  :pattern
  belongs_to  :classification_element

  after_save  :destroy_blank_classification_elements

  def field_descriptor
    self.classification_element.field_descriptor
  end

  def destroy_blank_classification_elements
    if self.classification_element_id.blank?
      self.destroy
    end
  end
end
