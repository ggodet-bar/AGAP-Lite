class AddPatSystemUpdateTextField < ActiveRecord::Migration
  def self.up
    add_column :pattern_systems, :update_field, :text
  end

  def self.down
    remove_column :pattern_systems, :update_field
  end
end
