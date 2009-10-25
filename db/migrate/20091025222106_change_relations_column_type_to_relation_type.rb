class ChangeRelationsColumnTypeToRelationType < ActiveRecord::Migration
  def self.up
    remove_column :relations, :type
    add_column :relations, :name, :string
  end

  def self.down
    add_column :relations, :type, :string
    remove_column :relations, :name
  end
end
