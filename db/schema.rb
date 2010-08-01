# This file is auto-generated from the current state of the database. Instead 
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your 
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100727083826) do

  create_table "classification_elements", :force => true do |t|
    t.integer  "field_descriptor_id"
    t.integer  "pattern_system_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "system_formalism_id"
  end

  create_table "classification_selections", :force => true do |t|
    t.integer  "pattern_id"
    t.integer  "classification_element_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.boolean  "is_sorting_patterns",  :default => false
    t.integer  "system_formalism_id"
  end

  create_table "image_associations", :force => true do |t|
    t.integer  "pattern_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "field_descriptor_id"
    t.integer  "mappable_image_id"
  end

  create_table "mappable_images", :force => true do |t|
    t.string   "image_file_name"
    t.integer  "pattern_system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.integer  "image_width"
    t.integer  "image_height"
    t.boolean  "is_temporary",       :default => false
  end

  create_table "maps", :force => true do |t|
    t.integer  "x_corner"
    t.integer  "y_corner"
    t.integer  "width"
    t.integer  "height"
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pattern_id"
    t.integer  "image_association_id"
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

  create_table "patterns", :force => true do |t|
    t.string   "name"
    t.integer  "pattern_system_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pattern_formalism_id"
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
    t.integer  "relation_descriptor_id"
  end

  create_table "string_instances", :force => true do |t|
    t.integer  "pattern_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "field_descriptor_id"
  end

  create_table "system_formalisms", :force => true do |t|
    t.string   "name"
    t.string   "author"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "text_instances", :force => true do |t|
    t.integer  "pattern_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "field_descriptor_id"
  end

end
