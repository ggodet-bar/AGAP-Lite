class AddPatternName < ActiveRecord::Migration
  def self.up
    add_column :process_patterns, :name, :string
    add_column :product_patterns, :name, :string
  end

  def self.down
    remove_column :process_patterns, :name
    remove_column :product_patterns, :name
  end
end
