Given /^a pattern system "([^\"]*)" with the name "([^\"]*)" and the author "([^\"]*)"$/ do |short_name, name, author|
  PatternSystem.transaction do
    PatternSystem.destroy_all
  end
  Factory(:pattern_system, :short_name => short_name, :name => name, :author => author)
end

When /^I clone the pattern system "([^\"]*)"$/ do |short_name|
  pending "I should be getting some work done here !"
  # visit clone_pattern_system_path(short_name)
end

When /^I go to the pattern system "([^\"]*)"$/ do |short_name|
  visit pattern_system_url(short_name)
end

When /^I create a pattern system with the short name "([^\"]*)" with the name "([^\"]*)" and the author "([^\"]*)"$/ do |short_name, name, author|
  visit new_pattern_system_path
  fill_in "Nom", :with => name
  fill_in "Abbréviation", :with => short_name
  fill_in "Auteur(s)", :with => author
  click_button "Créer"
end

Then /^There should be ([0-9]+) pattern systems? in the records$/ do |nb_pat_sys|
  # On compte le nombre d'occurrences ds la BD
  PatternSystem.count.should == nb_pat_sys.to_i
end