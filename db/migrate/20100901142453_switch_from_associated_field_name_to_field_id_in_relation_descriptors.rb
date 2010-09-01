class SwitchFromAssociatedFieldNameToFieldIdInRelationDescriptors < ActiveRecord::Migration
  def self.up
    remove_column :relation_descriptors, :associated_field_name
    add_column    :relation_descriptors, :associated_field_id, :integer
  end

  def self.down
    remove_column :relation_descriptors, :associated_field_id
    add_column :relation_descriptors, :associated_field_name, :string
  end
end
