class ChangeMapColumnNames < ActiveRecord::Migration
  def self.up
    add_column :maps, :process_pattern_id, :integer
  end

  def self.down
    remove_column :maps, :process_pattern_id
  end
end
