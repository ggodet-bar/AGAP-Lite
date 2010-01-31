class ClassificationSelection < ActiveRecord::Base
  belongs_to  :pattern
  belongs_to  :classification_element

  def field_descriptor
    self.classification_element.field_descriptor
  end

  def after_save
    if self.classification_element_id.blank?
      self.destroy
    end
  end
end
