class CreateRelations < ActiveRecord::Migration
  def self.up
    create_table :relations do |t|
      t.string :type
      t.integer :source_pattern_id
      t.integer :target_pattern_id

      t.timestamps
    end
  end

  def self.down
    drop_table :relations
  end
end
