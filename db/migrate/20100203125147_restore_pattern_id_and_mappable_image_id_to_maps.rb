class RestorePatternIdAndMappableImageIdToMaps < ActiveRecord::Migration
  def self.up
    add_column :maps, :pattern_id, :integer
    add_column :maps, :mappable_image_id, :integer
    remove_column :maps, :image_association_id
  end

  def self.down
    add_column :maps, :image_association_id, :integer
    remove_column :maps, :mappable_image_id
    remove_column :maps, :pattern_id
  end
end
