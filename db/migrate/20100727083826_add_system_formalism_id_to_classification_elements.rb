class AddSystemFormalismIdToClassificationElements < ActiveRecord::Migration
  def self.up
    add_column :classification_elements, :system_formalism_id, :integer
  end

  def self.down
    remove_column :classification_elements, :system_formalism_id
  end
end
