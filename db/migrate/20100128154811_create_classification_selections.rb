class CreateClassificationSelections < ActiveRecord::Migration
  def self.up
    create_table :classification_selections do |t|
      t.integer :pattern_id
      t.integer :classification_element_id

      t.timestamps
    end
  end

  def self.down
    drop_table :classification_selections
  end
end
