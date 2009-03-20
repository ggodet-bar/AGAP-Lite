class CreateUsePatterns < ActiveRecord::Migration
  def self.up
    create_table :use_patterns do |t|
      t.integer :source_pattern_id
      t.integer :target_pattern_id
      t.timestamps
    end
  end

  def self.down
    drop_table :use_patterns
  end
end
