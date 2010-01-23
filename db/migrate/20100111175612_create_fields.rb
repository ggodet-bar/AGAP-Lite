class CreateFields < ActiveRecord::Migration
  def self.up
    create_table :fields do |t|
      t.string :name
      t.string :section
      t.string :index
      t.string :type
      t.integer :system_formalism_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fields
  end
end
