require 'spec_helper'

describe Pattern do
  before(:each) do
    @new_pattern = Factory(:pattern)
  end

  after(:each) do
  end

  it "should create a new instance given valid attributes" do
    puts @new_pattern.name
    @new_pattern.should be_valid
    @new_pattern.should_not be_new_record
  end

  it "should allow adding mappable images" do
    puts @new_pattern.name
    @new_pattern.should have(0).mappable_image
    @new_pattern.should have(0).image_association
    new_mappable_image = @new_pattern.mappable_images.build(:pattern_system_id => @new_pattern.pattern_system_id)
    new_mappable_image.should be_new_record 
    @new_pattern.save.should be_true
    @new_pattern.should have(1).mappable_image
    @new_pattern.image_associations.count.should == 1
    @new_pattern.mappable_images.first.should_not be_new_record
  end
end
