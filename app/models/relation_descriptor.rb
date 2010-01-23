class RelationDescriptor < ActiveRecord::Base
  belongs_to :system_formalism

  def before_destroy
    errors.add_to_base "Cannot delete unalterable relation descriptors" unless is_alterable
  end
end
