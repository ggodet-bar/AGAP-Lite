class CreatePatternSystems < ActiveRecord::Migration
  def self.up
    create_table :pattern_systems do |t|
      t.string  :author
      t.string  :domain
      t.string :technology
      t.string  :name
      t.string  :root_pattern_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pattern_systems
  end
end
