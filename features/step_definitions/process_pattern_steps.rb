Given /^a pattern with the name "([^\"]*)" and the author "([^\"]*)"$/ do |name, author|
  ProcessPattern.transaction do
    PatternSystem.destroy_all
    ProcessPattern.destroy_all
    Factory(:process_pattern, :name => name, :author => author)
  end

  pattern = ProcessPattern.find_by_name(name)
  sys_pat = pattern.pattern_system
  pattern.pattern_system.should == sys_pat
  sys_pat.process_patterns.should be_include(pattern)
  pattern.should_not be_new_record
  sys_pat.should_not be_new_record
  pattern.name.should == name
end


