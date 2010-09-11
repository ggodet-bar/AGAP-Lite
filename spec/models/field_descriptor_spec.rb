#require 'spec_helper'

describe "A field descriptor" do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :section => "interface",
      :field_type => "mappable_image",
      :pattern_formalism_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    new_field_descriptor = FieldDescriptor.create(@valid_attributes)
    new_field_descriptor.should be_valid
    new_field_descriptor.should_not be_new_record
  end

end
