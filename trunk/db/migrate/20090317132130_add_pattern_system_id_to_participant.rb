class AddPatternSystemIdToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :pattern_system_id, :integer
  end

  def self.down
    remove_column :participants, :pattern_system_id
  end
end
