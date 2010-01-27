class AddDescriptionToSystemFormalism < ActiveRecord::Migration
  def self.up
    add_column :system_formalisms, :description, :text
  end

  def self.down
    remove_column :system_formalisms, :description
  end
end
