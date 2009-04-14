class DropUselessKeys < ActiveRecord::Migration
  def self.up
    remove_column :process_patterns, :participant_id
    remove_column :process_patterns, :mappable_image_id
    remove_column :pattern_systems, :process_pattern_id
    remove_column :pattern_systems, :product_pattern_id
  end

  def self.down
    add_column :process_patterns, :participant_id, :integer
    add_column :process_patterns, :mappable_image_id, :integer
    add_column :pattern_systems, :process_pattern_id, :integer
    add_column :pattern_systems, :product_pattern_id, :integer
  end
end
