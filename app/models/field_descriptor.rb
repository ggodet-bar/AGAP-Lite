class FieldDescriptor < ActiveRecord::Base
  belongs_to :pattern_formalism

  FORMALISM_FIELD_TYPES = %w( string text model_set mappable_image multi_classification classification ).freeze 

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
end
