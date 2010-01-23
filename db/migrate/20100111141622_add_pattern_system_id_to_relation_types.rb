class AddPatternSystemIdToRelationTypes < ActiveRecord::Migration
  def self.up
    add_column :relation_types, :pattern_system_id, :integer, :null => false
  end

  def self.down
    remove_column :relation_types, :pattern_system_id
  end
end
