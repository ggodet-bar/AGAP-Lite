namespace :agap do
  desc  "Deploy the pattern system to remote site"
  task  :deploy do
    contents = IO.read(File.dirname(__FILE__) + '/../crawler.rb')
    eval(contents)
  end
end