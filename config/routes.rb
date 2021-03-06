Pscore::Application.routes.draw do
 
  resources :boards


  resources :games do
    resources :fixtures
  end
  
  resources :users do
  resources :predicts;
  collection { post :get_records }
  end

  resources :users do
    collection { post :import }
  end

  resources :games do
    resources :predicts
  end

  resources :games do
    collection { post :import }
  end

  resources :games do
     resources :scoreboard
   end
   
    get 'scoreboards/index_match', :to => "scoreboards#index_match"
    get 'scoreboards/index_week', :to => "scoreboards#index_week"
    get 'scoreboards/scores_2014', :to => "scoreboards#scores_2014"
      
  resources :scoreboards do
    collection { post :generate }
  end
   
    get 'predicts/pastpredict', :to => "predicts#pastpredict"
   
    resources :predicts do
      collection { post :import }
    end
   
   resources :javascripts

  get "javascripts/dynamic_fixtures"
  
  match ':controller/:action/.:format'
      
  resources :sessions, only: [:new, :create, :destroy]
  
  namespace :api do
    resources :users
  end
   
   get 'fixtures/fix_by_comp', :to => "fixtures#fix_by_comp"
   get 'fixtures/fix_by_grid', :to => "fixtures#fix_by_grid"
   
   
   resources :fixtures do
     collection { post :import };
      collection { post :calc_user}
   end
   
  resources :fixtures  
  
  resources :fixtures do
    resources :predicts
  end
   
  resources :fixtures do
    resources :games
  end
   

  get "static_pages/options"
  match '/options', to: 'static_pages#options'
  match '/help',    to: 'static_pages#help'
  match '/home',   to: 'static_pages#home'
  
  match '/signup',  to: 'users#new'
   match '/signin',  to: 'sessions#new'
   match '/signout', to: 'sessions#destroy', via: :delete


 
  get "home/index"
 
  match '/' => "home#index", :as => :home
 
 
 
 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
     root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
