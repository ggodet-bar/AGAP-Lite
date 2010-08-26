class AddColorCodeToRelationDescriptors < ActiveRecord::Migration
  def self.up
    add_column :relation_descriptors, :color_code, :string, :default => "red"
  end

  def self.down
    remove_column :relation_descriptors, :color_code
  end
end
