class AdaptMapsFromTargetPatternIdToRelationId < ActiveRecord::Migration
  def self.up
    rename_column :maps, :target_pattern_id, :relation_id
  end

  def self.down
    rename_column :maps, :relation_id, :target_pattern_id
  end
end
