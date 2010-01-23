class RenameFieldAndRelationTypeTables < ActiveRecord::Migration
  def self.up
    rename_table :relation_types, :relation_descriptors
    rename_table :fields, :field_descriptors
  end

  def self.down
    rename_table :field_descriptors, :fields
    rename_table :relation_descriptors, :relation_types
  end
end
