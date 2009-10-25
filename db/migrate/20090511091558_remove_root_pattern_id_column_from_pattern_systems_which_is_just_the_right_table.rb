class RemoveRootPatternIdColumnFromPatternSystemsWhichIsJustTheRightTable < ActiveRecord::Migration
  def self.up
    remove_column :pattern_systems, :root_pattern_id
  end

  def self.down
    add_column :pattern_systems, :root_pattern_id, :integer
  end
end
