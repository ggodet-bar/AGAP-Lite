class AddPatternSystemShortName < ActiveRecord::Migration
  def self.up
    add_column :pattern_systems, :short_name, :string
  end

  def self.down
    remove_column :pattern_systems, :short_name
  end
end
