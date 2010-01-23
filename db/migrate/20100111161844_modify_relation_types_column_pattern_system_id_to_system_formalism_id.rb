class ModifyRelationTypesColumnPatternSystemIdToSystemFormalismId < ActiveRecord::Migration
  def self.up
    add_column :relation_types, :system_formalism_id, :integer, :null => false
    remove_column :relation_types, :pattern_system_id
  end

  def self.down
    add_column :relation_types, :pattern_system_id, :integer, :null =>false
    remove_column :relation_types, :system_formalism_id
  end
end
