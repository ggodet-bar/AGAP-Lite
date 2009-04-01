require 'test_helper'

class ProcessPatternTest < ActiveSupport::TestCase
  test "the ancesters" do
    a_pattern = process_patterns(:fourth_pattern)
    ancesters = a_pattern.ancesters
    assert ancesters.include?(process_patterns(:first_pattern)), "First pattern is not in hierarchy"
    assert ancesters.include?(process_patterns(:second_pattern)), "Second pattern is not in hierarchy"
    assert ancesters.include?(process_patterns(:third_pattern)), "Third pattern is not in hierarchy"
    assert !ancesters.include?(process_patterns(:fourth_pattern)), "Fourth pattern in hierarchy"
  end
end
