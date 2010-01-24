class ChangeFieldDescriptorTypeToFieldType < ActiveRecord::Migration
  def self.up
    rename_column :field_descriptors, :type, :field_type
  end

  def self.down
    rename_column :field_descriptors, :field_type, :type
  end
end
