ActionController::Routing::Routes.draw do |map|

  map.resources :pattern_systems, :collection => {:show_metamodels => :get} do |pat_system|
     pat_system.resources :patterns, :collection => {:show_pattern_types => :get}
     pat_system.resources :participants
  end

  map.resources :system_formalisms

  map.root :controller => 'high_voltage/pages', :action => 'show', :id => 'index'

  map.connect '/pattern_systems/:pattern_system_id/:controller/:action'
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action.format'
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action/:id'
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action/:id.format'
  
  map.connect ':controller/:action'
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
