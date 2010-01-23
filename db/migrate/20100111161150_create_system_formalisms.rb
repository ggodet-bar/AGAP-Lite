class CreateSystemFormalisms < ActiveRecord::Migration
  def self.up
    create_table :system_formalisms do |t|
      t.string :name
      t.string :author
      t.string :version

      t.timestamps
    end
  end

  def self.down
    drop_table :system_formalisms
  end
end
