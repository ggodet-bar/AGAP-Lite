class CreateTextInstances < ActiveRecord::Migration
  def self.up
    create_table :text_instances do |t|
      t.integer :pattern_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :text_instances
  end
end
