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
end