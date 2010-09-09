class FieldDescriptor < ActiveRecord::Base
  belongs_to :pattern_formalism
  belongs_to :system_formalism

  FORMALISM_FIELD_TYPES = %w( string text mappable_image multi_classification classification ).freeze 

  FIELD_MODELS = {
    'string' => StringInstance,
    'text'   => TextInstance,
    'mappable_image' => ImageAssociation,
    'multi_classification' => ClassificationElement,
    'classification' => ClassificationElement
  }.freeze

  validate :field_type_must_be_valid
  before_destroy :field_must_be_alterable

  def field_type_must_be_valid
    errors[:base] << "Invalid field type" \
      unless FORMALISM_FIELD_TYPES.include?(self.field_type)
  end

  def field_must_be_alterable
    errors[:base] << "Cannot delete unalterable field descriptors" \
      unless is_alterable
  end

  after_save do |field|
    FIELD_MODELS.each do |key, model|
      if key == field_type || (key.include?('classification') && field_type.include?('classification'))
        model.where(:field_descriptor_id => id).collect{|model_el| model_el.update_attribute(:is_active, true)}
      else
        model.where(:field_descriptor_id => id).collect{|model_el| model_el.update_attribute(:is_active, false)}
      end
    end
  end
end
