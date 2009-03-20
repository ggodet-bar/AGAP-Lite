class DropParticipationId < ActiveRecord::Migration
  def self.up
    remove_column :participations, :id 
  end

  def self.down
    add_column :participations, :id, :integer
  end
end
