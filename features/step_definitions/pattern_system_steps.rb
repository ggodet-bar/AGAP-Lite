# coding: utf-8

Given /^a pattern system "([^\"]*)" with the name "([^\"]*)" and the author "([^\"]*)"$/ do |short_name, name, author|
  PatternSystem.transaction do
    PatternSystem.destroy_all
  end
  Factory(:pattern_system, :short_name => short_name, :name => name, :author => author)
end

Given /^the locale is "([^\"]*)"$/ do |locale|
  I18n.locale = locale
end

When /^I add a pattern "([^\"]*)" with author "([^\"]*)" to the pattern system "([^\"]*)"$/ do |pat_name, pat_author, sys_pat_name|
  pat = Factory(:process_pattern, :name => pat_name, :author => pat_author)
  pat.should_not be_new_record
  sys = PatternSystem.find_by_short_name(sys_pat_name)
  sys.process_patterns = Array(pat)
  sys.save.should be_true
  sys.process_patterns.should_not be_empty
end

When /^I clone the pattern system "([^\"]*)"$/ do |short_name|
  visit clone_pattern_system_path(short_name)
end

Then /^the pattern system "([^\"]*)" should have ([0-9]+) patterns?$/ do |sys_pat_name, count| 
  PatternSystem.find_by_short_name(sys_pat_name).process_patterns.size.should == count.to_i
end


Then /^all the patterns of the new system should have "([^\"]*)" for a parent$/ do |sys_pat_name|
  sys = PatternSystem.find_by_short_name(sys_pat_name)
  sys.should_not be_nil
  sys.process_patterns.select{ |pattern| 
    pattern.pattern_system.short_name != sys.short_name}.should be_empty
end


When /^I go to the pattern system "([^\"]*)"$/ do |short_name|
  visit pattern_system_url(short_name)
end

When /^I create a pattern system with the short name "([^\"]*)" with the name "([^\"]*)" and the author "([^\"]*)"$/ do |short_name, name, author|
  visit new_pattern_system_path
  fill_in "Name", :with => name
  fill_in "Short name", :with => short_name
  fill_in "Author(s)", :with => author
  click_button "Create"
end

Then /^There should be ([0-9]+) (.*) in the records$/ do |nb_el, model_name|
  # On compte le nombre d'occurrences ds la BD
  case model_name
    when "pattern", "patterns"
      count = ProcessPattern.count
    when "pattern system", "pattern systems"
      count = PatternSystem.count
    when "map", "maps"
      count = Map.count
    else
      puts "Update the models configuration!"
  end 
  count.should == nb_el.to_i
end