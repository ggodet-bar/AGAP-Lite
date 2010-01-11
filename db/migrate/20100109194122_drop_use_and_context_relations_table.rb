class DropUseAndContextRelationsTable < ActiveRecord::Migration
  def self.up
  	drop_table :use_patterns
	drop_table :context_patterns
  end

  def self.down
    create_table :use_patterns do |t|
      t.integer :source_pattern_id
      t.integer :target_pattern_id
      t.timestamps
    end	

    create_table :context_patterns do |t|
	t.integer :source_pattern_id
	t.integer :target_pattern_id
    end

  end
end
