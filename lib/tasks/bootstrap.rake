namespace :bootstrap do
  desc "Add the default inalterable relations"
  task :default_relations => :environment do
    RelationType.create(:name => 'use', :is_reflexive => false, :is_alterable => false)
    RelationType.create(:name => 'require', :is_reflexive => false, :is_alterable => false)
  end

  desc "Run all bootstrapping tasks"
  task :all => [:default_relations]
end
