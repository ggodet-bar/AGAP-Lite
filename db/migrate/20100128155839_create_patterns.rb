class CreatePatterns < ActiveRecord::Migration
  def self.up
    create_table :patterns do |t|
      t.string :name
      t.integer :pattern_system_id

      t.timestamps
    end
  end

  def self.down
    drop_table :patterns
  end
end
