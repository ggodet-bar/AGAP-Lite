class NewJoinTableForMappableImagesWithModel < ActiveRecord::Migration
  def self.up
    create_table :image_associations, :force => true do |t|
      t.integer :process_pattern_id, :null => false
      t.integer :mappable_image_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :image_associations
  end
end
