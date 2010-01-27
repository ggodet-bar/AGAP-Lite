# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100127135728) do

  create_table "field_descriptors", :force => true do |t|
    t.string   "name"
    t.string   "section"
    t.string   "index"
    t.string   "field_type"
    t.integer  "pattern_formalism_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_alterable",         :default => true
    t.string   "description"
  end

  create_table "image_associations", :force => true do |t|
    t.integer  "process_pattern_id", :null => false
    t.integer  "mappable_image_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mappable_images", :force => true do |t|
    t.string   "filename"
    t.integer  "width"
    t.integer  "height"
    t.integer  "pattern_system_id"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size"
    t.string   "content_type"
    t.string   "thumbnail"
    t.integer  "field_descriptor_id"
  end

  create_table "maps", :force => true do |t|
    t.integer  "mappable_image_id"
    t.integer  "x_corner"
    t.integer  "y_corner"
    t.integer  "width"
    t.integer  "height"
    t.integer  "target_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "process_pattern_id"
  end

  create_table "participants", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pattern_system_id"
  end

  create_table "participations", :id => false, :force => true do |t|
    t.integer  "participant_id"
    t.integer  "process_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pattern_formalisms", :force => true do |t|
    t.string   "name",                                   :null => false
    t.integer  "system_formalism_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_main_pattern",     :default => false
  end

  create_table "pattern_systems", :force => true do |t|
    t.string   "author"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participant_id"
    t.text     "characteristics"
    t.text     "update_field"
    t.string   "short_name"
    t.string   "version"
    t.boolean  "first_level_is_phase"
    t.integer  "system_formalism_id"
  end

  create_table "process_patterns", :force => true do |t|
    t.string   "author"
    t.string   "classification"
    t.string   "processContext"
    t.string   "productContext"
    t.text     "problem"
    t.text     "forces"
    t.string   "process_model_uri"
    t.text     "process_solution"
    t.text     "product_solution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "application_case"
    t.text     "application_consequence"
    t.integer  "pattern_system_id"
    t.boolean  "is_root_pattern",         :default => false
  end

  create_table "relation_descriptors", :force => true do |t|
    t.string   "name",                                            :null => false
    t.boolean  "is_reflexive",                 :default => false
    t.string   "associated_field_name"
    t.string   "associated_field_description"
    t.boolean  "is_alterable",                 :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "system_formalism_id",                             :null => false
  end

  create_table "relations", :force => true do |t|
    t.integer  "source_pattern_id"
    t.integer  "target_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "relation_type_id",  :null => false
  end

  create_table "system_formalisms", :force => true do |t|
    t.string   "name"
    t.string   "author"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

end
