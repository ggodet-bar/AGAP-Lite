class DropJoinTableForMappableImages < ActiveRecord::Migration
  def self.up
    drop_table :process_patterns_mappable_images
  end

  def self.down
    create_table "process_patterns_mappable_images", :force => true do |t|
      t.integer  "process_pattern_id", :null => false
      t.integer  "mappable_image_id",  :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
