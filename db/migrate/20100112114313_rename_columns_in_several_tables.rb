class RenameColumnsInSeveralTables < ActiveRecord::Migration
  def self.up
    rename_column :field_descriptors, :system_formalism_id, :pattern_formalism_id
  end

  def self.down
    rename_column :field_descriptors, :pattern_formalism_id, :system_formalism_id
  end
end
