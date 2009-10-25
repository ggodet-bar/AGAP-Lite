class AddIsFirstLevelPhase < ActiveRecord::Migration
  def self.up
    add_column :pattern_systems, :first_level_is_phase, :boolean
  end

  def self.down
    remove_column :pattern_systems, :first_level_is_phase
  end
end
