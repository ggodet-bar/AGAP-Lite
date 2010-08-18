AgapLiteApp::Application.routes.draw do
  resources :pattern_systems do

    collection do
      get :show_metamodels
    end

    resources :patterns do
      collection do
        get :show_pattern_types
      end

      member do
        # post :create_relation
        post  :upload_file
      end
    end

    resources :participants
  end

  resources :system_formalisms

  match "/create_relation" => "patterns#create_relation", :as => :create_relation

  root :to => 'pattern_systems#index'
end
