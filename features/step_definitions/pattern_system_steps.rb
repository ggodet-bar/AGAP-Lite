Given /^a pattern system "([^\"]*)" with the name "([^\"]*)" and the author "([^\"]*)"$/ do |short_name, name, author|
  PatternSystem.create!(:short_name => short_name,
                        :name => name,
                        :author => author)
end

When /^I clone the pattern system "([^\"]*)"$/ do |short_name|
  pending "I should be getting some work done here !"
  # visit clone_pattern_system_path(short_name)
end

When /^I navigate to the pattern system "([^\"]*)"$/ do |short_name|
  visit pattern_system_url(short_name)
end

Then /^I should see the name "([^\"]*)" of the pattern system and its author "([^\"]*)"$/ do |name, author|
  response.body.should =~ /#{name}+/
  response.body.should =~ /#{author}+/
end

When /^I create a pattern system with the short name "([^\"]*)" with the name "([^\"]*)" and the author "([^\"]*)"$/ do |short_name, name, author|
  visit new_pattern_system_path
  fill_in "pattern_system[name]", :with => name
  fill_in "pattern_system[short_name]", :with => short_name
  fill_in "pattern_system[author]", :with => author
  click_button "Créer"
end

