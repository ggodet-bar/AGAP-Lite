require 'test_helper'

class ProcessPatternsControllerTest < ActionController::TestCase

  def setup
    @pattern_system = Factory(:pattern_system)
    @process_pattern = Factory(:process_pattern)
  end
  
  test "should refuse to save duplicate pattern" do
    post :create, {:process_pattern => {:name => "A pattern name", :author => "Bob le poulpe"}, :pattern_system_id  => @pattern_system.short_name}
    assert_no_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "A pattern name", :author => "Bob le poulpe"}, :pattern_system_id  => @pattern_system.short_name}
    end
    assert_template 'process_patterns/new'
  end
  
  test "should route to pattern_system" do
    get :index, {:pattern_system_id  => @pattern_system.short_name}
    assert_redirected_to pattern_system_path(@pattern_system)
  end
  
  test "should route to new process_pattern" do
    opts = {:controller => 'process_patterns', :action => 'new', :pattern_system_id => @pattern_system.short_name}
    assert_routing({:method => 'get', :path => "pattern_systems/#{@pattern_system.short_name}/process_patterns/new"}, opts)
  end
  
  test "should route to create process_pattern" do
    opts = {:controller => 'process_patterns', :action => 'create', :pattern_system_id => @pattern_system.short_name}
    assert_routing({:method => 'post', :path => "pattern_systems/#{@pattern_system.short_name}/process_patterns"}, opts)
  end
  
  test "should get new" do
    get :new, {:pattern_system_id  => @pattern_system.short_name}
    assert_response :success
  end

  test "should not accept pattern creation" do
    assert_no_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "Yay, a great name fo'sure"}, :pattern_system_id => @pattern_system.short_name}
      
      assert_template 'process_patterns/new'
    end
  end

  test "should create process_pattern" do
    assert_difference('ProcessPattern.count') do
      post :create, {:process_pattern => {:name => "Yay, a great name fo' sure", :author => "Bob le poulpe"}, :pattern_system_id  => @pattern_system.short_name}
    end

    assert_not_nil ProcessPattern.find_by_name("Yay, a great name fo' sure")
    assert_redirected_to([@pattern_system, assigns(:process_pattern)])
  end

  test "should save new image with new process_pattern" do
    assert_difference(['ProcessPattern.count','MappableImage.count']) do
        post :create, {
                        :process_pattern => {:name => "A pattern name", :author => "Bob le poulpe"},
                        :mappable_image => {:filename => "CycleSymphAugmente.png", :width => 800, :height => 954, :size => 201146, :content_type => 'image/png'},
                        :pattern_system_id  => @pattern_system.short_name}
    end

    assert_redirected_to([@pattern_system, assigns(:process_pattern)])
  end

  test "should show process_pattern" do
    get :show, {:id => @process_pattern.id, :pattern_system_id  => @pattern_system.short_name}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => @process_pattern.id, :pattern_system_id  => @pattern_system.short_name}
    assert_response :success
  end

  test "should update process_pattern" do
    put :update, {:id => @process_pattern.id, :process_pattern => {:name  => "This is a stupid pattern name"}, :pattern_system_id  => @pattern_system.short_name}, {:participants => [Factory(:participant).id, Factory(:participant).id]}
    assert_redirected_to [@pattern_system, assigns(:process_pattern)]
  end

  test "should destroy process_pattern" do
    assert_difference('ProcessPattern.count', -1) do
      delete :destroy, {:id => @process_pattern.id, :pattern_system_id  => @pattern_system.short_name}
    end

    assert_redirected_to @pattern_system
  end
  
end
