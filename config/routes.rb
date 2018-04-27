Rails.application.routes.draw do

  root 'products#root'

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'
  delete '/logout', to: "users#destroy", as: "logout"

  # this is a new route to limit view of order details for merchant
  get '/sold_order/:id' , to: 'orders#merchant_order_show', as: 'sold_order'

  get '/order' , to: 'sessions#index', as: 'order'
  post '/order' , to: 'sessions#create', as: 'add_to_order'
  patch '/order' , to: 'sessions#update', as: 'update_order'
  delete '/order' , to: 'sessions#destroy', as: 'delete_order'

  get '/order/:id' , to: 'orders#show', as: 'order_details'

  resources :orders, only: [:index, :new, :create]

  resources :products do
    resources :reviews, only: [:create, :new]
  end

  resources :categories, only: [:index, :create, :new, :show]

  resources :order_items, only: [:index, :create, :edit, :update]

  resources :users do
    resources :products, except: [:delete]
    resources :order_items, only: [:index]
  end

end
