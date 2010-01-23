class AddDescriptionAttributeToFieldDescriptor < ActiveRecord::Migration
  def self.up
    add_column :field_descriptors, :description, :string
  end

  def self.down
    remove_column :field_descriptors, :description
  end
end
