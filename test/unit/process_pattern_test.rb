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
  
  test "a used pattern should be linked to by the main pattern" do
    @pattern_system = Factory(:pattern_system, :registered_relations  => [{:type => :fake_relation, :is_reflexive => false}])
    @used_pattern = Factory(:process_pattern, :pattern_system => @pattern_system)
    @main_pattern = Factory(:process_pattern, :pattern_system => @pattern_system)
    assert @main_pattern.pattern_system.eql?(@pattern_system)
    assert @used_pattern.pattern_system.eql?(@pattern_system)
    assert @pattern_system.process_patterns.include?(@main_pattern)
    assert @pattern_system.process_patterns.include?(@used_pattern)
    assert @pattern_system.registered_relations.any?{|rel| rel[:type] == :fake_relation}
    
    assert @main_pattern.fake_relation.size == 0
    @main_pattern.fake_relation = [@used_pattern]
    assert @main_pattern.fake_relation.size == 1, "The relation was not registered correctly (size is #{@main_pattern.fake_relation.size})!"
    assert @main_pattern.fake_relation.any?{|relation| relation.target_pattern == @used_pattern && relation.name == "fake_relation"}, "The used pattern is not amongst the main pattern's relations"
  end
  
  test "reflexive relations" do
    @pattern_system = Factory(:pattern_system, :registered_relations  => [{:type => :reflexive_relation, :is_reflexive => true}])
    @used_pattern = Factory(:process_pattern, :pattern_system => @pattern_system)
    @main_pattern = Factory(:process_pattern, :pattern_system => @pattern_system)
    @main_pattern.reflexive_relation = [@used_pattern]
    assert @main_pattern.reflexive_relation.size == 1, "The size is #{@main_pattern.reflexive_relation.size}"
    assert @used_pattern.reflexive_relation.size == 1
    assert @main_pattern.reflexive_relation.any?{|relation| relation.target_pattern.eql?(@used_pattern) && relation.name == "reflexive_relation"} &&
      @used_pattern.reflexive_relation.any?{|relation| relation.target_pattern.eql?(@main_pattern) && relation.name == "reflexive_relation"}
  end
  
  test "should allow adding, removing then adding relations" do
    @pattern_system = Factory(:pattern_system, :registered_relations  => [{:type => :fake_relation, :is_reflexive => false}])
    @used_pattern1 = Factory(:process_pattern, :pattern_system => @pattern_system)
    @used_pattern2 = Factory(:process_pattern, :pattern_system => @pattern_system)    
    @main_pattern = Factory(:process_pattern, :pattern_system => @pattern_system)
    
    @main_pattern.fake_relation = [@used_pattern1]
    @main_pattern.fake_relation = [@used_pattern2]
    assert @main_pattern.fake_relation.size == 1
    assert @main_pattern.fake_relation.first.target_pattern.eql? @used_pattern2
    assert Relation.count == 1
  end
  
  test "should allow adding, removing then adding reflexive relations" do
    @pattern_system = Factory(:pattern_system, :registered_relations  => [{:type => :reflexive_relation, :is_reflexive => true}])
    @used_pattern1 = Factory(:process_pattern, :pattern_system => @pattern_system)
    @used_pattern2 = Factory(:process_pattern, :pattern_system => @pattern_system) 
    @used_pattern3 = Factory(:process_pattern, :pattern_system => @pattern_system)  
    @main_pattern = Factory(:process_pattern, :pattern_system => @pattern_system)
    
    @main_pattern.reflexive_relation = [@used_pattern1]
    @main_pattern.reflexive_relation = [@used_pattern2, @used_pattern3]
    assert Relation.count == 4
  end
end
