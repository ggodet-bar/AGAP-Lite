class AddPatternIdAndIndex < ActiveRecord::Migration
  def self.up
    add_column :pattern_systems, :process_pattern_id, :integer
    add_column :pattern_systems, :product_pattern_id, :integer
  end

  def self.down
    remove_column :pattern_systems, :product_pattern_id
    remove_column :pattern_systems, :process_pattern_id
  end
end
