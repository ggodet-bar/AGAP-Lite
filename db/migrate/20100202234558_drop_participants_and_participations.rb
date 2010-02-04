class DropParticipantsAndParticipations < ActiveRecord::Migration
  def self.up
    drop_table :participants
    drop_table :participations
  end

  def self.down
    create_table :participations do |t|
      t.integer  "participant_id"
      t.integer  "process_pattern_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :participants do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "pattern_system_id"
    end
  end
end
