class AddIsMainPatternToPatternFormalism < ActiveRecord::Migration
  def self.up
    add_column :pattern_formalisms, :is_main_pattern, :boolean, :default => false
  end

  def self.down
    remove_column :pattern_formalisms, :is_main_pattern
  end
end
