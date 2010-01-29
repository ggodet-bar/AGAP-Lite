class CreateStringInstances < ActiveRecord::Migration
  def self.up
    create_table :string_instances do |t|
      t.integer :pattern_id
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :string_instances
  end
end
