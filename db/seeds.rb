# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'formalism_loader'

SystemFormalism.delete_all
PatternFormalism.delete_all
FieldDescriptor.delete_all
RelationDescriptor.delete_all
obj = YAML::load_file("#{Rails.root}/config/system_formalisms.yml")
FormalismLoader::load_from_yaml(obj)
#require 'active_record/fixtures'
#Fixtures.create_fixtures("#{Rails.root}/config", "system_formalisms")

