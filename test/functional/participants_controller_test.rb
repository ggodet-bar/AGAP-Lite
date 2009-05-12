require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase

  def setup
    @pattern_system = Factory(:pattern_system)
  end

  test "should refuse to create and redirect to pattern_system" do
    assert_no_difference('Participant.count') do
      post :create, {:participant => {}, :pattern_system_id => @pattern_system.short_name}
    end
    
    assert_redirected_to  @pattern_system
  end

  test "should destroy participant and redirect to pattern_system" do
    @participant = Factory(:participant)
    assert_difference('Participant.count', -1) do
      delete :destroy, {:id => @participant.id, :pattern_system_id  => @pattern_system.short_name}
    end
    
    assert_redirected_to @pattern_system
  end
  
end
