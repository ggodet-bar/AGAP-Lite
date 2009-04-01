class CreateMappableImages < ActiveRecord::Migration
  def self.up
    create_table :mappable_images do |t|
      t.string  :filename
      t.integer :width
      t.integer :height
      t.integer :pattern_id
      t.integer :map_id
      t.timestamps
    end
  end

  def self.down
    drop_table :mappable_images
  end
end
