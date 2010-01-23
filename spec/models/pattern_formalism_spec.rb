require 'spec_helper'

def have_a_field_descriptor_named(expected)
  simple_matcher("a field descriptor named #{expected}") do |given, matcher|
    matcher.failure_message = "expected to find a field descriptor named #{expected}"
    matcher.negative_failure_message = "did not expect to find a field descriptor named #{expected}"
    given.field_descriptors.any?{|fie| fie.name == expected}
  end
end

describe PatternFormalism do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
    @pattern = PatternFormalism.new
  end

  it "should create a new instance given valid attributes" do
    PatternFormalism.create!(@valid_attributes)
  end

  it "should have default unalterable field descriptors such as 'name', 'problem'" do
    @pattern.should have(2).field_descriptors
    @pattern.should have_a_field_descriptor_named('name')
    @pattern.should have_a_field_descriptor_named('problem')
    lambda {
      @pattern.field_descriptors.each do |fie|
        fie.destroy
      end
    }.should_not change(@pattern, :field_descriptors)
  end
  
  it "should only have fields included in one of the main sections" do
    # TODO Add some fields

    @pattern.field_descriptors.all?{|fie| $FORMALISM_SECTIONS.include?(fie.section)}.should be_true
  end
end
