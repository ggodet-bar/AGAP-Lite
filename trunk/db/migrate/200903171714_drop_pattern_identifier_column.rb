class DropPatternIdentifierColumn < ActiveRecord::Migration
  def self.up
    remove_column :process_patterns, :identifier
  end

  def self.down
    add_column  :process_patterns, :identifier, :integer
  end
end
