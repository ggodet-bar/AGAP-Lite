require File.dirname(__FILE__) + '/../spec_helper'


describe MappableImage do

  before(:each) do
    @image = MappableImage.new
  end

  it "should allow uploading images" do
        @image.should be_new_record
  end
end