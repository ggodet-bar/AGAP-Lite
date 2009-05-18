Given /^the following patterns? for pattern system "([^\"]*)":$/ do |short_name, patterns|
  sys = PatternSystem.find_by_short_name(short_name)
  sys.process_patterns = [] if sys.process_patterns.blank?
  patterns.hashes.each do |hash|
     sys.process_patterns << ProcessPattern.create(hash)
  end
end

When /^I add a pattern "([^\"]*)" with author "([^\"]*)" to the pattern system "([^\"]*)"$/ do |pat_name, pat_author, sys_pat_name|
  visit new_pattern_system_process_pattern_path(PatternSystem.find_by_short_name(sys_pat_name))
  lambda {
    fill_in "Name", :with => pat_name
    fill_in "Author(s)", :with => pat_author
    click_button  "Create"
    # On n'utilise pas la factory, qui créée automatiquement des liens vers mappable_image et pattern_system
  }.should change(ProcessPattern, :count).by(1)
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
  response.should have_tag(tag_name)
  # response.should contain("<#{tag_name}>")
end

Given /^I add an image "([^\"]*)" associated to the pattern with name "([^\"]*)"$/ do |filename, pattern_name|
  an_image = Factory(:mappable_image, :filename => filename)
  the_pattern = ProcessPattern.find_by_name(pattern_name)
  the_pattern.mappable_image = an_image
  the_pattern.save
end

Then /^I should see an image$/ do
  response.should have_xpath("//*[@id='method_image']")
end

When /^I should see a link to pattern "([^\"]*)" from pattern system "([^\"]*)" in the pattern body$/ do |pat_name, sys_pat|
  the_pattern = PatternSystem.find_by_short_name(sys_pat).process_patterns.select{ |pattern|  pattern.name == pat_name}.first
  response.should have_xpath("//div[contains(@class,'block')]/ul/li/a[contains(@href, #{the_pattern.id.to_s})]")
end
