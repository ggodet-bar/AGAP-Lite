require 'test_helper'

class ProcessPatternsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new, {}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system).id}
    assert_response :success
  end

  test "should create process_pattern" do
    assert_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "Yay, a great name fo' sure"}}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system).id}
    end

    assert_redirected_to process_pattern_path(assigns(:process_pattern))
  end

  test "should show process_pattern" do
    get :show, {:id => process_patterns(:first_pattern).id}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => process_patterns(:first_pattern).id}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system).id}
    assert_response :success
  end

  test "should update process_pattern" do
    put :update, {:id => process_patterns(:first_pattern).id, :process_pattern => {:name  => "This is a stupid pattern name"}}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system).id, :participants => [participants(:vendeur).id, participants(:acheteur).id]}
    assert_redirected_to process_pattern_path(assigns(:process_pattern))
  end

  test "should destroy process_pattern" do
    assert_difference('ProcessPattern.count', -1) do
      delete :destroy, {:id => process_patterns(:first_pattern).id}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system)}
    end

    assert_redirected_to pattern_systems(:a_test_pattern_system)
  end
  
  test "should route to pattern_system" do
    get :index, {}, {:pattern_system_id  => pattern_systems(:a_test_pattern_system).id}
    assert_redirected_to :controller => 'pattern_systems', :action => 'show', :id  => pattern_systems(:a_test_pattern_system).id
  end
end
