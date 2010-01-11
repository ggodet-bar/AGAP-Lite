class CreateRelationTypes < ActiveRecord::Migration
  def self.up
    create_table :relation_types do |t|
      t.string :name, :null => false
      t.boolean :is_reflexive, :default => false
      t.string :associated_field_name
      t.string :associated_field_description
      t.boolean :is_alterable, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :relation_types
  end
end
