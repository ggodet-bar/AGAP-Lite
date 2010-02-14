class AddTemporaryFieldToMappableImage < ActiveRecord::Migration
  def self.up
    add_column :mappable_images, :is_temporary, :boolean, :default => false
  end

  def self.down
    remove_column :mappable_images, :is_temporary
  end
end
