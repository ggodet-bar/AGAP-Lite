class MakeBaseFieldTypesUnalterable < ActiveRecord::Migration
  def self.up
    add_column :fields, :is_alterable, :boolean, :default => true
  end

  def self.down
    remove_column :fields, :is_alterable
  end
end
