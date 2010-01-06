class ChangeImageColumnName < ActiveRecord::Migration
  def self.up
    rename_column :process_patterns, :process_image_id, :mappable_image_id
  end

  def self.down
    rename_column :process_patterns, :mappable_image_id, :process_image_id
    
  end
end
