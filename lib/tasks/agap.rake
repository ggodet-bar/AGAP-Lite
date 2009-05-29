require 'rake/packagetask'

namespace :agap do
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
  
  Rake::PackageTask.new("backup_#{Time.now.strftime('%y%m%d_%H%M')}", :noversion) do |pack|
    pack.need_zip = true
    pack.package_dir = "#{RAILS_ROOT}/backups"
    unless ENV['names'].nil?
      ENV['names'].split(',').each do |a_name|
        if File.exist?("public/images/#{a_name}")
          pack.package_files.include("public/images/#{a_name}/**/*")
        else
          puts "DIR #{a_name} does not exist!"
        end
      end
    end
    pack.package_files.include("db/symphony_patterns_bak.sql")
  end
end