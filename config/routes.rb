Rails.application.routes.draw do

  # we should make another root homepage with fewer items to show
  root 'products#index'

  # get '/order', to: 'orders#index', as: 'order'
  # post '/order', to: 'orders#create', as: 'add_to_order'

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'
  delete '/logout', to: "users#destroy", as: "logout"

  # Orders
    get '/orders' , to: 'orders#index', as: 'orders'
  # resources :sessions
  get '/order' , to: 'sessions#index', as: 'order'
  post '/order' , to: 'sessions#create', as: 'add_to_order'
  patch '/order' , to: 'sessions#update', as: 'update_order'
  delete '/order' , to: 'sessions#destroy', as: 'delete_order'

  post '/orderitem' , to: 'order_items#create', as: 'create_order'

  resources :products do
    resources :reviews
  end

  resources :categories


  # resources :orders

  resources :users do
    resources :products, except: [:delete]
    resources :orders, only: [:index, :show]
    resources :order_items, only: [:index]
  end

end
