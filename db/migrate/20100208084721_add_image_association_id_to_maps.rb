class AddImageAssociationIdToMaps < ActiveRecord::Migration
  def self.up
    add_column :maps, :image_association_id, :integer
  end

  def self.down
    remove_column :maps, :image_association_id
  end
end
