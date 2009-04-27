class ChangeMapColumnName < ActiveRecord::Migration
  def self.up
    rename_column :maps, :pattern_id, :target_pattern_id
  end

  def self.down
    rename_column :maps, :target_pattern_id, :pattern_id
  end
end
