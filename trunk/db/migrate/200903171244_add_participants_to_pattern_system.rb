class AddParticipantsToPatternSystem < ActiveRecord::Migration
  def self.up
    add_column :pattern_systems, :participant_id, :integer
  end

  def self.down
    remove_column :pattern_systems, :participant_id
  end
end
