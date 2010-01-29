require 'spec_helper'

describe StringInstance do
  before(:each) do
    @valid_attributes = {
      :pattern_id => 1,
      :content => "value for content"
    }
  end

  it "should create a new instance given valid attributes" do
    StringInstance.create!(@valid_attributes)
  end
end
