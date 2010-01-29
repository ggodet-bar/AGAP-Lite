class AddPatternFormalismIdToPattern < ActiveRecord::Migration
  def self.up
    add_column :patterns, :pattern_formalism_id, :integer
  end

  def self.down
    remove_column :patterns, :pattern_formalism_id
  end
end
