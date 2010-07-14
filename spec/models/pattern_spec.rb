require 'spec_helper'

describe Pattern do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :pattern_system_id => 1
    }
    @pattern = Pattern.new @valid_attributes
  end

  after(:each) do
    @pattern.destroy
  end

  it "should create a new instance given valid attributes" do
    Pattern.create!(@valid_attributes)
  end

  it "should allow adding mappable images" do
    @pattern.should have(0).mappable_image
    @pattern.should have(0).image_association
    new_mappable_image = @pattern.mappable_images.build(:pattern_system_id => @pattern.pattern_system_id)
    new_mappable_image.should be_new_record 
    @pattern.save.should be_true
    @pattern.should have(1).mappable_image
    @pattern.image_associations.count.should == 1
    @pattern.mappable_images.first.should_not be_new_record
  end
end
