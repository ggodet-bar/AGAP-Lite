class AddIsRootPatternColumnToPatterns < ActiveRecord::Migration
  def self.up
    add_column :process_patterns, :is_root_pattern, :boolean, :default => false    
  end

  def self.down
    remove_column :process_patterns, :is_root_pattern
  end
end
