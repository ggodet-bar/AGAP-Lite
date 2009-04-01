class CreateParticipations < ActiveRecord::Migration
  def self.up
    create_table :participations do |t|
      t.integer :participant_id
      t.integer :process_pattern_id
      t.timestamps
    end
    remove_column :participants, :process_pattern_id
    remove_column :participants, :product_pattern_id
  end

  def self.down
    drop_table :participations
    add_column :participants, :process_pattern_id, :integer
    add_column :participants, :product_pattern_id, :integer
  end
end
