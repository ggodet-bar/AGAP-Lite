#require 'spec_helper'

describe "A field descriptor" do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :section => "interface",
      :field_type => "modelset"
    }
  end

  it "should create a new instance given valid attributes" do
    FieldDescriptor.create!(@valid_attributes)
  end

end
