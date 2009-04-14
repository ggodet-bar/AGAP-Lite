require 'test_helper'

class MappableImageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the parent pattern should be accessible" do
    @an_image = mappable_images(:an_image)
    assert @an_image.send(:parent_pattern_name) == 'test_system'
  end
end
