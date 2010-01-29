class AddIsSortingPatternsAttributeToFieldDescriptor < ActiveRecord::Migration
  def self.up
    add_column  :field_descriptors, :is_sorting_patterns, :boolean, :default => false
  end

  def self.down
    remove_column :field_descriptors, :is_sorting_patterns
  end
end
