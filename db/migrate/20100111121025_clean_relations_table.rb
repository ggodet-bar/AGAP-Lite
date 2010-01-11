class CleanRelationsTable < ActiveRecord::Migration
  def self.up
    remove_column :relations, :name
  end

  def self.down
    add_column :relations, :name, :string
  end
end
