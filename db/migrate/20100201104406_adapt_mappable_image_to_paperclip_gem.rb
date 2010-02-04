class AdaptMappableImageToPaperclipGem < ActiveRecord::Migration
  def self.up
    rename_column :mappable_images, :filename, :image_file_name
    rename_column :mappable_images, :content_type, :image_content_type
    rename_column :mappable_images, :size, :image_file_size
    add_column :mappable_images, :image_updated_at, :datetime
    remove_column :mappable_images, :width
    remove_column :mappable_images, :height
    remove_column :mappable_images, :thumbnail
    remove_column :mappable_images, :map_id
  end

  def self.down
    add_column :mappable_images, :map_id, :integer
    add_column :mappable_images, :thumbnail, :string
    add_column :mappable_images, :height, :integer
    add_column :mappable_images, :width, :integer
    remove_column :mappable_images, :image_updated_at
    rename_column :mappable_images, :image_file_size, :size
    rename_column :mappable_images, :image_content_type, :content_type
    rename_column :mappable_images, :image_file_name, :filename
  end
end
