class AddAssociationBetweenPatternSystemAndSystemFormalism < ActiveRecord::Migration
  def self.up
    add_column  :pattern_systems, :system_formalism_id, :integer
  end

  def self.down
    remove_column :pattern_systems, :system_formalism_id
  end
end
