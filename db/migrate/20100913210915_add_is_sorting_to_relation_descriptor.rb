class AddIsSortingToRelationDescriptor < ActiveRecord::Migration
  def self.up
    add_column :relation_descriptors, :is_sorting, :boolean, :default => false
  end

  def self.down
    remove_column :relation_descriptors, :is_sorting
  end
end
