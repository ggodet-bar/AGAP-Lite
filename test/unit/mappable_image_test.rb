require 'test_helper'

class MappableImageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the parent pattern should be accessible" do
    @an_image = Factory(:mappable_image)
    assert @an_image.pattern_system.author == 'Bob le poulpe'
  end
end
