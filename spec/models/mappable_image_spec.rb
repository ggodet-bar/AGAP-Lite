require File.dirname(__FILE__) + '/../spec_helper'


describe MappableImage, "managing the images that get displayed in the patterns" do

  before(:each) do
    @image = MappableImage.new
  end

  it "should verify that the image is a new record " do
        @image.should be_new_record
  end
  
end