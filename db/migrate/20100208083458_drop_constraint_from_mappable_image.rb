class DropConstraintFromMappableImage < ActiveRecord::Migration
  def self.up
    remove_column :image_associations, :mappable_image_id
    add_column :image_associations, :mappable_image_id, :integer
  end

  def self.down
    remove_column :image_associations, :mappable_image_id
    add_column :image_associations, :mappable_image_id, :integer, :null => false
  end
end
