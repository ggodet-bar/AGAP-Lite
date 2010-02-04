class ImageAssociationCompatibility < ActiveRecord::Migration
  def self.up
    rename_column :image_associations, :process_pattern_id, :pattern_id
  end

  def self.down
    rename_column :image_associations, :pattern_id, :process_pattern_id
  end
end
