Rails.application.routes.draw do

  root 'products#root'

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'
  delete '/logout', to: "users#destroy", as: "logout"

  # Orders
  get '/orders' , to: 'orders#index', as: 'orders'
  get '/orders/new', to: 'orders#new', as: 'new_order'


  get '/order' , to: 'sessions#index', as: 'order'
  post '/order' , to: 'sessions#create', as: 'add_to_order'
  patch '/order' , to: 'sessions#update', as: 'update_order'
  delete '/order' , to: 'sessions#destroy', as: 'delete_order'

  post '/orderitem' , to: 'order_items#create', as: 'create_order'

  resources :products do
    resources :reviews
  end

  resources :categories

  resources :order_items

  resources :users do
    resources :products, except: [:delete]
    resources :orders, only: [:index, :show]
    resources :order_items, only: [:index]
  end

end
