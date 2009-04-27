require 'test_helper'

class ProcessPatternsControllerTest < ActionController::TestCase
  
  test "should refuse to save duplicate pattern" do
    post :create, {:process_pattern => {:name => "A pattern name", :author => "Bob le poulpe"}, :pattern_system_id  => pattern_systems(:a_test_pattern_system).short_name}
    assert_no_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "A pattern name", :author => "Bob le poulpe"}, :pattern_system_id  => pattern_systems(:a_test_pattern_system).short_name}
    end
    assert_template 'process_patterns/new'
  end
  
  test "should route to pattern_system" do
    pattern_system = Factory(:pattern_system)
    get :index, {:pattern_system_id  => pattern_system.short_name}
    assert_redirected_to pattern_system_path(pattern_system)
  end
  
  test "should route to new process_pattern" do
    pattern_system = Factory(:pattern_system)
    opts = {:controller => 'process_patterns', :action => 'new', :pattern_system_id => pattern_system.short_name}
    assert_routing({:method => 'get', :path => "pattern_systems/#{pattern_system.short_name}/process_patterns/new"}, opts)
  end
  
  test "should route to create process_pattern" do
    pattern_system = Factory(:pattern_system)
    opts = {:controller => 'process_patterns', :action => 'create', :pattern_system_id => pattern_system.short_name}
    assert_routing({:method => 'post', :path => "pattern_systems/#{pattern_system.short_name}/process_patterns"}, opts)
  end
  
  test "should get new" do
    get :new, {:pattern_system_id  => Factory(:pattern_system).short_name}
    assert_response :success
  end

  test "should not accept pattern creation" do
    assert_no_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "Yay, a great name fo'sure"}, :pattern_system_id => Factory(:pattern_system).short_name}
      
      assert_template 'process_patterns/new'
    end
  end

  test "should create process_pattern" do
    pattern_system = Factory(:pattern_system)    
    assert_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "Yay, a great name fo' sure", :author => "Bob le poulpe"}, :pattern_system_id  => pattern_system.short_name}
    end

    assert_not_nil ProcessPattern.find_by_name("Yay, a great name fo' sure")
    assert_redirected_to([pattern_system, assigns(:process_pattern)])
  end

  test "should save new image with new process_pattern" do
    pattern_system = Factory(:pattern_system)    
    assert_difference(['ProcessPattern.count','MappableImage.count']) do
        post :create, {
                        :process_pattern => {:name => "A pattern name", :author => "Bob le poulpe"},
                        :mappable_image => {:filename => "/Users/godetg/Documents/RadAGAP/public/images/loading.gif", :width => 120, :height => 180, :size => 2000, :content_type => 'image/gif'},
                        :pattern_system_id  => pattern_system.short_name}
    end
    assert_redirected_to([pattern_system, assigns(:process_pattern)])
  end

  test "should show process_pattern" do
    pattern_system = Factory(:pattern_system)
    get :show, {:id => process_patterns(:first_pattern).id, :pattern_system_id  => pattern_system.short_name}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => process_patterns(:first_pattern).id, :pattern_system_id  => pattern_systems(:a_test_pattern_system).short_name}
    assert_response :success
  end

  test "should update process_pattern" do
    put :update, {:id => process_patterns(:first_pattern).id, :process_pattern => {:name  => "This is a stupid pattern name"}, :pattern_system_id  => pattern_systems(:a_test_pattern_system).short_name}, {:participants => [participants(:vendeur).id, participants(:acheteur).id]}
    assert_redirected_to [pattern_systems(:a_test_pattern_system), assigns(:process_pattern)]
  end

  test "should destroy process_pattern" do
    assert_difference('ProcessPattern.count', -1) do
      delete :destroy, {:id => process_patterns(:first_pattern).id, :pattern_system_id  => pattern_systems(:a_test_pattern_system).short_name}
    end

    assert_redirected_to pattern_systems(:a_test_pattern_system)
  end
  
end
