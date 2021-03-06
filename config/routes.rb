Rails.application.routes.draw do

  get '/listen', to: 'listen#index', as: 'listen'

  get 'admin/access/index', as: :admin_index
  get 'admin/access/login', as: :login
  get 'admin/access/logout', as: :logout
  post 'admin/access/attempt_login', as: :attempt_login

  
  get '/admin/streamitems/:year/:month/:day', to: 'admin/streamitems#index', as: 'streamitems_show'
  get '/admin/streamitems/:year/:month/:day/new', to: 'admin/streamitems#new', as: 'streamitems_new'
  post '/admin/streamitems/:year/:month/:day/move', to: 'admin/streamitems#move', as: 'streamitems_move'

  get '/api/get/stream/:year/:month/:day/metadata', to: 'api/api#getStreamMetadata', as: 'api_stream_metadata'
  get '/api/get/stream/:year/:month/:day/items', to: 'api/api#getStreamItems', as: 'api_stream_items'
  get '/api/get/stream/current', to: 'api/api#getCurrentItem', as: 'api_stream_current'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :streamitems
      resources :shows do
        resources :episodes, shallow: true
      end
    end
  end

  namespace :admin do
    get '/episodes/all', to: 'episodes#all', as: 'episodes'
    get '/shows/all', to: 'shows#all', as: 'shows'
    resources :mediafiles, :streamitems, :access
    resources :users, shallow: true do
      resources :shows, shallow: true do
        resources :episodes
      end
    end
  end


  get '/home', to: 'home#index', as: 'home'

  #match ":controller(/:action(/:index))", :via => [:get,:post]
  root 'home#index'
  # mp3 file uploading

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
