class AddPatternIdToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :process_pattern_id, :integer
  end

  def self.down
    remove_column :participants, :process_pattern_id
  end
end
