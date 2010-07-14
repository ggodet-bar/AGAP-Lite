class RelationDescriptor < ActiveRecord::Base
  belongs_to :system_formalism
  before_destroy :relation_must_be_alterable

  def relation_must_be_alterable
    errors[:base] << "Cannot delete unalterable relation descriptors" unless is_alterable
  end
end
