require 'spec_helper'

describe FieldDescriptor do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :section => "value for section",
      :index => "value for index",
      :type => "value for type",
      :pattern_formalism_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    FieldDescriptor.create!(@valid_attributes)
  end
end
