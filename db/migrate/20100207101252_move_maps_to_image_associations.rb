class MoveMapsToImageAssociations < ActiveRecord::Migration
  def self.up
    remove_column :maps, :pattern_id
    add_column :maps, :pattern_id, :integer
    remove_column :maps, :mappable_image_id
  end

  def self.down
    add_column :maps, :mappable_image_id, :integer
    remove_column :maps, :pattern_id
    add_column :maps, :pattern_id, :integer
  end
end
