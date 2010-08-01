class AddSystemFormalismIdToFieldDescriptors < ActiveRecord::Migration
  def self.up
    add_column :field_descriptors, :system_formalism_id, :integer
  end

  def self.down
    remove_column :field_descriptors, :system_formalism_id
  end
end
