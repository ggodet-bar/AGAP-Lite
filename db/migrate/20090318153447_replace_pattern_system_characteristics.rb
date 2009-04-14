class ReplacePatternSystemCharacteristics < ActiveRecord::Migration
  def self.up
    add_column  :pattern_systems, :characteristics, :text
    remove_column :pattern_systems, :domain
    remove_column :pattern_systems, :technology
  end

  def self.down
    remove_column :pattern_systems, :characteristics
    add_column :pattern_systems, :domain, :string
    add_column :pattern_systems, :technology, :string
  end
end
