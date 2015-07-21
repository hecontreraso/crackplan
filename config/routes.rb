Rails.application.routes.draw do
  
  resources :events, except: [:new]
  
  devise_for :users, controllers: { sessions: "users/sessions" }
  
  devise_scope :user do
    authenticated :user do
      root :to => 'events#index', as: :authenticated_root
      get '/beta/sign_in' => 'events#index'
    end
    unauthenticated :user do
      root :to => 'users/sessions#new', as: :unauthenticated_root
      get '/beta/sign_in' => 'users/sessions#internal_landing'
    end
  end

  post '/events/:id/toggle_assistance' => 'events#toggle_assistance'
  post '/profile/:id/toggle_follow' => 'profile#toggle_follow'
  get '/profile/:id' => 'profile#index', as: :profile


  get '/about' => 'pages#about'
  get '/terms' => 'pages#terms'
  get '/help' => 'pages#help'
  get '/contact' => 'pages#contact'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
