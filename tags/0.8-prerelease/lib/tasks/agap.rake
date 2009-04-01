namespace :agap do
  desc  "Deploy the pattern system to remote site"
  task  :deploy do
    contents = IO.read(File.dirname(__FILE__) + '/../crawler.rb')
    
    # Backup of the pattern system(s)
    system("sqlite3 #{File.dirname(__FILE__)}/../../db/RadAGAP_development.sqlite3 .dump > #{File.dirname(__FILE__)}/../../db/symphony_patterns_bak.sql")
    
    eval(contents)
  end
end