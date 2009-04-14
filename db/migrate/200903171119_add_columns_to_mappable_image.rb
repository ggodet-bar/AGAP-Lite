class AddColumnsToMappableImage < ActiveRecord::Migration
  def self.up
    add_column :mappable_images, :size, :integer
    add_column :mappable_images, :content_type, :string
    add_column :mappable_images, :thumbnail, :string
  end

  def self.down
    remove_column :mappable_images, :size
    remove_column :mappable_images, :content_type
    remove_column :mappable_images, :thumbnail
  end
end
