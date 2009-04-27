Given /^a pattern with the name "([^\"]*)" and the author "([^\"]*)"$/ do |name, author|
  ProcessPattern.transaction do
    PatternSystem.destroy_all
  end
  Factory(:process_pattern, :name => name, :author => author)
  pattern = ProcessPattern.find_by_name(name)
  sys_pat = pattern.pattern_system
  pattern.pattern_system.should == sys_pat
  sys_pat.process_patterns.should be_include(pattern)
  pattern.should_not be_new_record
  sys_pat.should_not be_new_record
  pattern.name.should == name
end


Then /^There should be ([0-9]+) patterns? in the records$/ do |nb_pat|
  # On compte le nombre d'occurrences ds la BD
  ProcessPattern.count.should == nb_pat.to_i
end