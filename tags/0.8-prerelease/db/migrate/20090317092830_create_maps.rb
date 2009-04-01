class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.integer :mappable_image_id
      t.integer :x_corner
      t.integer :y_corner
      t.integer :width
      t.integer :height
      t.integer :pattern_id
      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
