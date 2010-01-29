require 'spec_helper'

describe ClassificationElement do
  before(:each) do
    @valid_attributes = {
      :field_descriptor_id => 1,
      :pattern_system_id => 1,
      :name => "value for name",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    ClassificationElement.create!(@valid_attributes)
  end
end
