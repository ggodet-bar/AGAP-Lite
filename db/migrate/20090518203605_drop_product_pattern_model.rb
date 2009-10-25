class DropProductPatternModel < ActiveRecord::Migration
  def self.up
    drop_table :product_patterns
  end

  def self.down
    create_table "product_patterns", :force => true do |t|
      t.string   "identifier",        :null => false
      t.string   "author"
      t.string   "classification"
      t.text     "problem"
      t.text     "forces"
      t.integer  "product_image_id"
      t.string   "product_model_uri"
      t.text     "product_solution"
      t.string   "uses"
      t.string   "requires"
      t.string   "alternative"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
      t.integer  "pattern_system_id"
    end
  end
end
