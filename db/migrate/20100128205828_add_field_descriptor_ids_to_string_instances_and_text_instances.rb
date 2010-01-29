class AddFieldDescriptorIdsToStringInstancesAndTextInstances < ActiveRecord::Migration
  def self.up
    add_column :string_instances, :field_descriptor_id, :integer
    add_column :text_instances, :field_descriptor_id, :integer
  end

  def self.down
    remove_column :text_instances, :field_descriptor_id
    remove_column :string_instances, :field_descriptor_id
  end
end
