require 'test_helper'

class PatternSystemsControllerTest < ActionController::TestCase

  test "should refuse to save duplicate system" do
    post :create, {:pattern_system => {:name => "A pattern system name", :author => "Bob le poulpe"}}
    assert_no_difference('PatternSystem.count') do
      post :create, {:process_pattern => {:name => "A pattern system name", :author => "Bob le poulpe"}}
    end
    assert_template 'pattern_systems/new'
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pattern_systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should refuse to create pattern_system and redirect to new" do
    assert_no_difference('PatternSystem.count') do
      post :create, :pattern_system => {}
    end
    
    assert_template 'pattern_systems/new'
  end

  test "should create pattern_system" do
    assert_difference('PatternSystem.count') do
      post :create, :pattern_system => {:name => 'A new pattern system', :author => 'Bob le poulpe', :short_name => 'new_pat' }
    end

    assert_redirected_to pattern_system_path(assigns(:pattern_system))
  end

  test "should show pattern_system" do
    get :show, :id => pattern_systems(:a_test_pattern_system).short_name
    assert_response :success
  end
  
  test "should show new pattern system" do
    get :show, :id => pattern_systems(:a_new_pattern_system).short_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => pattern_systems(:a_test_pattern_system).short_name}
    assert_response :success
  end

  test "should update pattern_system" do
    put :update, :id => pattern_systems(:a_test_pattern_system).short_name, :pattern_system => { }
    assert_redirected_to pattern_system_path(assigns(:pattern_system))
  end

  test "should destroy pattern_system" do
    assert_difference('PatternSystem.count', -1) do
      delete :destroy, :id => pattern_systems(:a_test_pattern_system).short_name
    end

    assert_redirected_to pattern_systems_path
  end
  
  test "should route to index" do
    assert_routing '/pattern_systems', {:controller  => 'pattern_systems', :action  => 'index'}
  end
end
