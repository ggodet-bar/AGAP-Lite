class ChangeMappableImageColumnNameToPatternSystemId < ActiveRecord::Migration
  def self.up
    rename_column :mappable_images, :process_pattern_id, :pattern_system_id
  end

  def self.down
    rename_column :mappable_images, :pattern_system_id, :process_pattern_id
  end
end
