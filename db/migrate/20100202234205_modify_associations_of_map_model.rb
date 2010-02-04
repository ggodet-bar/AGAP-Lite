class ModifyAssociationsOfMapModel < ActiveRecord::Migration
  def self.up
    remove_column :maps, :mappable_image_id
    remove_column :maps, :process_pattern_id
    add_column :maps, :image_association_id, :integer
  end

  def self.down
    remove_column :maps, :image_association_id
    add_column :maps, :process_pattern_id, :integer
    add_column :maps, :mappable_image_id, :integer
  end
end
