class CreatePatternFormalisms < ActiveRecord::Migration
  def self.up
    create_table :pattern_formalisms do |t|
      t.string :name, :null => false
      t.integer :system_formalism_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pattern_formalisms
  end
end
