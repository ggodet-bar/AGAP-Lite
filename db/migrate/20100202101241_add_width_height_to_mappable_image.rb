class AddWidthHeightToMappableImage < ActiveRecord::Migration
  def self.up
    add_column :mappable_images, :image_width, :integer
    add_column :mappable_images, :image_height, :integer
  end

  def self.down
    remove_column :mappable_images, :image_height
    remove_column :mappable_images, :image_width
  end
end
