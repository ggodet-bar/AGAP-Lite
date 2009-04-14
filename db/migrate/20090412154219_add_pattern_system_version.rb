class AddPatternSystemVersion < ActiveRecord::Migration
  def self.up
    add_column :pattern_systems, :version, :string
  end

  def self.down
    remove_column :pattern_systems, :version
  end
end
