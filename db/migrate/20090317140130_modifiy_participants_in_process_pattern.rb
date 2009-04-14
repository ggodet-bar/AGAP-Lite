class ModifiyParticipantsInProcessPattern < ActiveRecord::Migration
  def self.up
    remove_column :process_patterns, :participant
    add_column :process_patterns, :participant_id, :integer
  end

  def self.down
    add_column  :process_patterns, :participant, :string
    remove_column :process_patterns, :participant_id
  end
end
