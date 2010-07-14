# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


obj = YAML::load_file("#{Rails.root}/config/standard_formalisms.yml")
FormalismLoader::load_from_yaml(obj)
