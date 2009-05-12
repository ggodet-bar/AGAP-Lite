require 'test_helper'

class ProcessPatternTest < ActiveSupport::TestCase
  test "the ancesters" do
    @first_pattern = Factory(:process_pattern)
    @second_pattern = Factory(:process_pattern, :context_patterns => Array(@first_pattern))
    @third_pattern = Factory(:process_pattern, :context_patterns => Array(@second_pattern))
    @fourth_pattern = Factory(:process_pattern, :context_patterns => Array(@third_pattern))

    ancesters = @fourth_pattern.ancesters
    assert ancesters.include?(@first_pattern), "First pattern is not in hierarchy"
    assert ancesters.include?(@second_pattern), "Second pattern is not in hierarchy"
    assert ancesters.include?(@third_pattern), "Third pattern is not in hierarchy"
    assert !ancesters.include?(@fourth_pattern), "Fourth pattern in hierarchy"
  end
end
