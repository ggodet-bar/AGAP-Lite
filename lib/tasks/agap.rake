require 'rake/packagetask'

namespace :agap do
  
  desc "Create some basic formalisms (GAMMA, P-SIGMA)"
  task :create_formalisms => :environment do
    require File.dirname(__FILE__) + '/../formalism_loader.rb'
    SystemFormalism.all.each do |sys|
      sys.destroy
      print '.'
    end
    puts "Existing formalisms were destroyed"
    obj = YAML::load_file(File.dirname(__FILE__) + '/../../config/standard_formalisms.yml')
    FormalismLoader::load_from_yaml(obj)
    puts "Finished loading the formalisms"
  end

  desc  "Deploy the pattern system to remote site"
  task  :deploy  => [:backup] do
    contents = IO.read(File.dirname(__FILE__) + '/../crawler.rb')
    eval(contents)
  end
  
  desc "Backup the database"
  task  :backup do
    # Backup of the pattern system(s)
    system("sqlite3 #{File.dirname(__FILE__)}/../../db/RadAGAP_development.sqlite3 .dump > #{File.dirname(__FILE__)}/../../db/symphony_patterns_bak.sql")
    print "DB should have been backed up\n"
  end
  
  desc "Backup the system"
  task  :backup_system => [:backup, :package] do
  end

  desc "Delete unused temporary images"
  task :clean_tmp_images => :environment do
    tmp_images = MappableImage.find(:all, :conditions => {:is_temporary => true})
    count = tmp_images.count
    tmp_images.each(&:destroy)
    puts "Deleted #{count} image(s)"
  end
  
  Rake::PackageTask.new("backup_#{Time.now.strftime('%y%m%d_%H%M')}", :noversion) do |pack|
    pack.need_zip = true
    pack.package_dir = Rails.root.join("backups").to_s
    unless ENV['names'].nil?
      ENV['names'].split(',').each do |a_name|
        if File.exist?("public/images/#{a_name}")
          pack.package_files.include("public/images/#{a_name}/**/*")
        else
          print "DIR #{a_name} does not exist!"
        end
      end
    end
    pack.package_files.include("db/symphony_patterns_bak.sql")
  end
end
