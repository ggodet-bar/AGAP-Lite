require 'spec_helper'

describe Pattern do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :pattern_system_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Pattern.create!(@valid_attributes)
  end
end
