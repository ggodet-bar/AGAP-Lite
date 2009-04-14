class AddPatternSystemIdToProcessAndProduct < ActiveRecord::Migration
  def self.up
    add_column :process_patterns, :pattern_system_id, :integer
    add_column :product_patterns, :pattern_system_id, :integer
    
  end

  def self.down
    remove_column :product_patterns, :pattern_system_id
    remove_column :process_patterns, :pattern_system_id
  end
end
