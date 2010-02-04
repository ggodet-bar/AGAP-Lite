class AdaptRelationColumnName < ActiveRecord::Migration
  def self.up
    remove_column :relations, :relation_type_id
    add_column :relations, :relation_descriptor_id, :integer
  end

  def self.down
    remove_column :relations, :relation_descriptor_id
    add_column :relations, :relation_type_id, :integer
  end
end
