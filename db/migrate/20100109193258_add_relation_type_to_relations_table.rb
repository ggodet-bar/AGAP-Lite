class AddRelationTypeToRelationsTable < ActiveRecord::Migration
  def self.up
  	add_column :relations, :relation_type_id, :integer, :null => false
  end

  def self.down
  	remove_column :relations, :relation_type_id
  end
end
