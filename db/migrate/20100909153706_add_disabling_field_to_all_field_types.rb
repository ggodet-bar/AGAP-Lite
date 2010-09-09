class AddDisablingFieldToAllFieldTypes < ActiveRecord::Migration
  def self.up
    add_column :image_associations, :is_active, :boolean, :default => true
    add_column :text_instances, :is_active, :boolean, :default => true
    add_column :string_instances, :is_active, :boolean, :default => true
    add_column :classification_elements, :is_active, :boolean, :default => true
  end

  def self.down
    remove_column :classification_elements, :is_active
    remove_column :string_instances, :is_active
    remove_column :text_instances, :is_active
    remove_column :image_associations, :is_active
  end
end
