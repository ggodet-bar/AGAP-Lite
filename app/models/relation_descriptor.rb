class RelationDescriptor < ActiveRecord::Base
  belongs_to :system_formalism
  before_destroy :relation_must_be_alterable
  belongs_to :associated_field, :class_name => 'FieldDescriptor', :foreign_key => 'associated_field_id'

  validates_uniqueness_of :is_sorting, :scope => :system_formalism_id
  validate :cannot_be_sorting_and_reflexive

  def cannot_be_sorting_and_reflexive
    errors.add(:is_reflexive, "can't be reflexive while also used for sorting patterns") \
      if is_sorting && is_reflexive
  end

  def relation_must_be_alterable
    errors[:base] << "Cannot delete unalterable relation descriptors" unless is_alterable
  end
end
