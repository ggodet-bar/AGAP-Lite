Given /^a pattern with the name "([^\"]*)" and the author "([^\"]*)"$/ do |name, author|
  Factory(:process_pattern, :name => name, :author => author)
  pattern = ProcessPattern.find_by_name(name)
  sys_pat = pattern.pattern_system
  pattern.pattern_system.should == sys_pat
  sys_pat.process_patterns.should be_include(pattern)
  pattern.should_not be_new_record
  sys_pat.should_not be_new_record
  pattern.name.should == name
end

When /^I add a map with the coordinates "([^\"]*)" and the target pattern "([^\"]*)" to the pattern "([^\"]*)"$/ do |coords, target, source|
  the_coords = coords.split(",").collect{|a_coord| a_coord.to_i}
  source_pattern = ProcessPattern.find_by_name(source)
  target_pattern = ProcessPattern.find_by_name(target)
  source_pattern.should_not be_nil
  target_pattern.should_not be_nil
  ajax(:get, "/pattern_systems/#{source_pattern.pattern_system.short_name}/process_patterns/save_map/#{source_pattern.id}", 
    {:x => the_coords[0], :y => the_coords[1], :w => the_coords[2], :h => the_coords[3], :target_pattern_id => target_pattern.id}  )
  response.should be_success
end

Then /^I should see a "([^\"]*)" tag$/ do |tag_name|
  have_tag(tag_name)
  # response.should contain("<#{tag_name}>")
end

Given /^an image "([^\"]*)" associated to the pattern with name "([^\"]*)"$/ do |filename, pattern_name|
  an_image = Factory(:mappable_image, :filename => filename)
  the_pattern = ProcessPattern.find_by_name(pattern_name)
  the_pattern.mappable_image = an_image
  the_pattern.save
end