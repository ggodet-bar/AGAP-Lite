
require "rubygems"
require "watir-webdriver"

WEB_ROOT = "http://localhost:3000"


###########################################
#
# HELPERS
#
###########################################

def create_field(field_type, field_name="Sample field name")
  case field_type
    when /simple classification/
      Factory(:field_descriptor, :name => field_name, :field_type => "classification", :pattern_formalism => @pattern_formalism)
    when /multi classification/
      Factory(:field_descriptor, :name => field_name, :field_type => "multi_classification", :pattern_formalism => @pattern_formalism)
    when /mappable image/
      Factory(:field_descriptor, :name => field_name, :field_type => "mappable_image", :pattern_formalism => @pattern_formalism)
  end
end

def create_pattern_system(pattern_system_name = nil)
  system_formalism = Factory(:system_formalism)
  @pattern_formalism = Factory(:pattern_formalism, :system_formalism => system_formalism)
  if pattern_system_name
    @pattern_system = @pattern_system = Factory(:pattern_system, :name => pattern_system_name, :system_formalism => system_formalism)
  else
    @pattern_system = Factory(:pattern_system, :system_formalism => system_formalism)
  end
end


###########################################
#
# GIVEN
#
###########################################

Given /^I browse to (.+)$/ do |dest|
  BROWSER.goto WEB_ROOT + path_to(dest)
end


Given /^I have a pattern system$/ do
  create_pattern_system
end

Given /^I have a pattern system named "([^\"]*)"$/ do |name|
  create_pattern_system(name)
end

Given /^the pattern system formalism has an anonymous (.+)$/ do |field_type|
  create_field(field_type)
end

Given /^the pattern system formalism has a (.+) named "(.+)"$/ do |field_type, field_name|
  create_field(field_type, field_name)
end

Given /^the pattern system has the following classification elements for the field named "(.+)":$/ do |field_name, classif_table|
  field = FieldDescriptor.find_by_name(field_name)
  field.should_not be_nil
  classif_table.hashes.each do |entry|
    Factory(:classification_element, :name => entry['name'], :pattern_system => @pattern_system, :field_descriptor => field)
  end
end

Given /^I have a pattern named "(.+)"$/ do |name|
  Factory(:pattern, :pattern_system => @pattern_system, :pattern_formalism => @pattern_formalism, :name => name)
end

Given /^I have a mappable image attached to the pattern "([^\"]*)" for the field "(.+)"$/ do |name, field_name|
  file = File.new(File.join(RAILS_ROOT, "features", "upload-files", "18.jpg"))
  image = Factory(:mappable_image, :image => file, :pattern_system => @pattern_system)
  Factory(:image_association, :mappable_image => image, :pattern => Pattern.find_by_name(name), :field_descriptor => FieldDescriptor.find_by_name(field_name))
end

Given /^I follow the "(.+)" link$/ do |link_text|
  BROWSER.link(:text, link_text).click
end



###########################################
#
# WHEN
#
###########################################

When /^I fill the (\d+)(st|nd|rd|th) text field with "(.+)"$/ do |index, _, content|
  #BROWSER.text_field(:xpath, "//input[@type=\"text\"][#{index}]").should exist
  #BROWSER.text_field(:xpath, "//input[@type=\"text\"][#{index}]").click
  BROWSER.text_field(:index, index.to_i).set(content)
end


When /^I press the "(.+)" button$/ do |name|
  BROWSER.button(:value, name).click
end

When /^I upload a file with valid data for the image named "([^\"]*)"$/ do |arg1|
  BROWSER.file_fields.first.set(File.join(RAILS_ROOT, 'features', 'upload-files','18.jpg'))
end

When /^I should wait (\d+) seconds?$/ do |n|
  sleep n.to_i 
end

When /^I click on the "([^\"]*)" image$/ do |alt_name|
  BROWSER.image(:alt, alt_name).click
end


###########################################
#
# THEN
#
###########################################

Then /^I should see the text "(.+)"$/ do |text|
  BROWSER.text.should include(text)
end

Then /^I should not see the text "(.+)"$/ do |text|
  BROWSER.text.should_not include(text)
end

Then /^I should see (\d+) (.+) elements?$/ do |n, element_type|
  #n.to_i.times{|i| BROWSER.send(element_type.gsub(/\s/,"_").to_sym, :index, i + 1).should exist}
  #BROWSER.should have(n.to_i).send(element_type.gsub(/\s/,"_").concat("s").to_sym)
  BROWSER.send(element_type.gsub(/\s/,"_").concat("s").to_sym).select{|el| el.visible?}.count.should == n.to_i
end

Then /^I should see a valid image$/ do
  BROWSER.dls.first.style.should =~ /18\.jpg/
end

Then /^the select list for field "([^\"]*)" should include the following options:$/ do |field_name, table|
  field = FieldDescriptor.find_by_name(field_name)
  field_array = FieldDescriptor.find_all_by_field_type(field.field_type).map(&:id)
  index = field_array.index(field.id)
  table.hashes.each do |entry|
    is_selected = entry['selected'] == "true" ? true : false
    is_disabled = entry['disabled'] == "true" ? true : false
    list = BROWSER.select_lists.select{|l| l.visible?}[index - 1]
    list.options.any? do |el|
      el.text == entry['name'] &&
      list.option(:text, el.text).selected? == is_selected && 
      list.option(:text, el.text).disabled? == is_disabled
    end.should be_true
  end
end

