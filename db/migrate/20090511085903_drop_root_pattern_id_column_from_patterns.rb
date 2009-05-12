class DropRootPatternIdColumnFromPatterns < ActiveRecord::Migration
  def self.up
    remove_column :process_patterns, :root_pattern_id
  end

  def self.down
    add_column :process_patterns, :root_pattern_id, :integer
  end
end
