Rails.application.routes.draw do

  root 'products#root'

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'
  delete '/logout', to: "users#destroy", as: "logout"

  # resources :sessions
  get '/order' , to: 'sessions#index', as: 'order'
  post '/order' , to: 'sessions#create', as: 'add_to_order'
  patch '/order' , to: 'sessions#update', as: 'update_order'
  delete '/order' , to: 'sessions#destroy', as: 'delete_order'

  get '/order/:id' , to: 'orders#show', as: 'order_details'

  post '/orderitem' , to: 'order_items#create', as: 'create_order'

  # Orders
  get '/orders' , to: 'orders#index', as: 'orders'
  get '/orders/new', to: 'orders#new', as: 'new_order'

  resources :products do
    resources :reviews, only: [:index, :create, :new, :show]
  end

  resources :categories, only: [:index, :create, :new]

  resources :order_items, only: [:index, :show, :create, :edit, :update]

  resources :users do
    resources :products, except: [:delete]
    resources :orders, only: [:index, :show]
    resources :order_items, only: [:index]
  end

end
