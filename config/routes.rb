CTFLogistics::Application.routes.draw do

  # resources :items

  get "items/create" => 'items#create'
  post "items/create" => 'items#create'
  get "items/add" => 'items#add'
  post "items/add" => 'items#add'
  get 'items/approve' => 'items#approve'
  get 'items/approve' => 'items#approve'
  get "items/destroy"
  get "items/update"
  post "items/update"
  get "items/plus"
  get "items/minus"
  get "items/return"
  get 'items/user_dashboard' => 'items#user_dashboard'
  get 'items/admin_dashboard' => 'items#admin_dashboard'

  match ':controller(/:action(/:id))', :via => [:get]
  match ':controller(/:action(/:id))', :via => [:post]

  get "users/index"
  post "users/login"
  get "users/logout"
  get "users/new"
  get "users/destroy"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

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
