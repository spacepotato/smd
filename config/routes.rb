Rails.application.routes.draw do
  

  resources :tickets

  resources :comments

  post '/search', to: 'search#search', :as => :search
  post 'events/:id' =>'events#follow_event'
  put 'events/:id' =>'events#unfollow_event'
  delete 'home/show/:id' => 'comments#destroy'

  post 'events/:id/reserve_ticket' => 'events#reserve_ticket', as: :reserve_ticket

  post 'clubs/:id/add_admin' => 'clubs#add_admin', as: :add_admin
  post 'clubs/:club_id/:user_id/destroy' =>'clubs#remove_admin' , :as=>:remove_admin


  
  resources :messages

  resources :events

  resources :clubs
  resources :club_admins

  resources :comments
  
  

  get 'home/show' =>'home#show',:as=>:show

  devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    root 'home#show'

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
