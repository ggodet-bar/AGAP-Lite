class AddBelongsToFieldDescriptorToMappable < ActiveRecord::Migration
  def self.up
    add_column :mappable_images, :field_descriptor_id, :integer
  end

  def self.down
    remove_column :mappable_images, :field_descriptor_id
  end
end
