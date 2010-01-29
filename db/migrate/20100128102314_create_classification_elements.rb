class CreateClassificationElements < ActiveRecord::Migration
  def self.up
    create_table :classification_elements do |t|
      t.integer :field_descriptor_id
      t.integer :pattern_system_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :classification_elements
  end
end
