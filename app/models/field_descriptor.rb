class FieldDescriptor < ActiveRecord::Base
  belongs_to :pattern_formalism

  # TODO Compléter les field types!!
  FORMALISM_FIELD_TYPES = %w( string text model_set mappable_image multi_classification classification ) 

  validate :field_type_must_be_valid

  def field_type_must_be_valid
    errors.add_to_base("Invalid field type") \
      unless FORMALISM_FIELD_TYPES.include?(self.field_type)
  end

  def before_destroy
    errors.add_to_base "Cannot delete unalterable field descriptors" \
      unless is_alterable
  end
end
