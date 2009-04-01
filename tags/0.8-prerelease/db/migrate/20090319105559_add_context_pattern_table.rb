class AddContextPatternTable < ActiveRecord::Migration
  def self.up
    create_table :context_patterns, :force  => true, :id  => false do |t|
      t.integer :source_pattern_id
      t.integer :target_pattern_id
    end
  end

  def self.down
    drop_table :context_patterns
  end
end
