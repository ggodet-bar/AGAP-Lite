require 'test_helper'

class ProcessPatternTest < ActiveSupport::TestCase
  test "the ancestors" do
    @first_pattern = Factory(:process_pattern)
    @second_pattern = Factory(:process_pattern, :context_patterns => Array(@first_pattern))
    @third_pattern = Factory(:process_pattern, :context_patterns => Array(@second_pattern))
    @fourth_pattern = Factory(:process_pattern, :context_patterns => Array(@third_pattern))

    ancestors = @fourth_pattern.ancestors
    assert ancestors.include?(@first_pattern), "First pattern is not in hierarchy"
    assert ancestors.include?(@second_pattern), "Second pattern is not in hierarchy"
    assert ancestors.include?(@third_pattern), "Third pattern is not in hierarchy"
    assert !ancestors.include?(@fourth_pattern), "Fourth pattern in hierarchy"
  end
end
