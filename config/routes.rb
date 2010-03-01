ActionController::Routing::Routes.draw do |map|
  # map.resources :pattern_systems
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  map.connect 'pattern_systems/:pattern_system_id/patterns/tmp_images/:id.js', :controller => 'patterns', :action => 'tmp_images'
  map.connect 'pattern_systems/:pattern_system_id/patterns/tmp_upload/:id.js', :controller => 'patterns', :action => 'tmp_upload'
  
  
  # Named routes
  map.clone_pattern_system 'pattern_systems/:id/clone', :controller => 'pattern_systems', :action => 'clone'
  map.deploy_pattern_system 'pattern_systems/:id/deploy', :controller => 'pattern_systems', :action => 'deploy'
  map.show_system_metamodels 'pattern_systems/show_metamodels', :controller => 'pattern_systems', :action => 'show_metamodels'
  map.show_pattern_types 'pattern_systems/:pattern_system_id/patterns/show_pattern_types', :controller => 'patterns', :action => 'show_pattern_types'

    map.resources :pattern_systems do |pat_system|
       pat_system.resources :patterns
       pat_system.resources :participants
    end

    map.resources :system_formalisms
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  #map.root :controller => "pattern_systems"
  #map.resources :pages,
  #  :controller => 'pages',
  #  :only => [:show]
  map.root :controller => 'high_voltage/pages', :action => 'show', :id => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  # map.with_options  :controller => 'process_patterns' do |pattern|
  #   
  # end
  
  # map.connect 'pattern_systems/:short_name', :controller => 'pattern_systems', :action => 'find_by_short_name'
  
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action'
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action.format'
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action/:id'
  map.connect '/pattern_systems/:pattern_system_id/:controller/:action/:id.format'
  
  map.connect ':controller/:action'
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
