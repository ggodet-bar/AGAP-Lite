class DropNonGenericeProcessPatternColumns < ActiveRecord::Migration
  def self.up
    remove_column :process_patterns, :uses
    remove_column :process_patterns, :requires
    remove_column :process_patterns, :alternative
    
  end

  def self.down
    add_column  :process_patterns, :uses, :string
    add_column  :process_patterns, :requires, :string
    add_column  :process_patterns, :alternative, :string
  end
end
