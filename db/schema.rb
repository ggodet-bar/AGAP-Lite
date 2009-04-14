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

ActiveRecord::Schema.define(:version => 20090412154219) do

  create_table "context_patterns", :id => false, :force => true do |t|
    t.integer "source_pattern_id"
    t.integer "target_pattern_id"
  end

  create_table "mappable_images", :force => true do |t|
    t.string   "filename"
    t.integer  "width"
    t.integer  "height"
    t.integer  "process_pattern_id"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size"
    t.string   "content_type"
    t.string   "thumbnail"
  end

  create_table "maps", :force => true do |t|
    t.integer  "mappable_image_id"
    t.integer  "x_corner"
    t.integer  "y_corner"
    t.integer  "width"
    t.integer  "height"
    t.integer  "pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "pattern_systems", :force => true do |t|
    t.string   "author"
    t.string   "name"
    t.string   "root_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participant_id"
    t.text     "characteristics"
    t.text     "update_field"
    t.string   "short_name"
    t.string   "version"
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
    t.string   "uses"
    t.string   "requires"
    t.string   "alternative"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "pattern_system_id"
    t.text     "application_case"
    t.text     "application_consequence"
  end

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

  create_table "use_patterns", :force => true do |t|
    t.integer  "source_pattern_id"
    t.integer  "target_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
