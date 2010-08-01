class FieldDescriptor < ActiveRecord::Base
  belongs_to :pattern_formalism
  belongs_to :system_formalism

  FORMALISM_FIELD_TYPES = %w( string text model_set mappable_image multi_classification classification ).freeze 

  validate :field_type_must_be_valid
  # validates_presence_of :pattern_formalism_id, 
  #   :unless => Proc.new {|f| f.system_formalism_id.present?}
  # validates_presence_of :system_formalism_id,
  #   :unless => Proc.new {|f| f.pattern_formalism_id.present?}
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
