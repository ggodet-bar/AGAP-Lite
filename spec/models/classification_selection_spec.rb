require 'spec_helper'

describe ClassificationSelection do
  before(:each) do
    @valid_attributes = {
      :pattern_id => 1,
      :classification_element_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ClassificationSelection.create!(@valid_attributes)
  end
end
