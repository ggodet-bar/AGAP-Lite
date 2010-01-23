class FieldDescriptor < ActiveRecord::Base
  belongs_to :pattern_formalism

  # TODO Compléter les field types!!
  $FORMALISM_FIELD_TYPES = nil 

  def before_destroy
    errors.add_to_base "Cannot delete unalterable field descriptors" \
      unless is_alterable
  end
end
