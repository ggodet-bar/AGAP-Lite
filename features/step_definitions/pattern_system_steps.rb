# coding: utf-8

Given /^I have the following system formalism names?:$/ do |pat_names|
  pat_names.hashes.each do |entry|
    Factory(:system_formalism, :name => entry['name'])
  end
  SystemFormalism.count.should == pat_names.hashes.size
end

Given /^I have (\d+) pattern systems?$/ do |n|
  system_formalism = Factory(:system_formalism)
  n.to_i.times{Factory(:pattern_system)}
end

Given /^the locale is "([^\"]*)"$/ do |locale|
  I18n.locale = locale
end

