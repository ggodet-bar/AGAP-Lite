class MoveFieldDescriptorIdFromMappableImageToImageAssociation < ActiveRecord::Migration
  def self.up
    remove_column :mappable_images, :field_descriptor_id
    add_column :image_associations, :field_descriptor_id, :integer
  end

  def self.down
    remove_column :image_associations, :field_descriptor_id
    add_column :mappable_images, :field_descriptor_id
  end
end
