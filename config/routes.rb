Rails.application.routes.draw do

  root 'products#root'

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'
  delete '/logout', to: "users#destroy", as: "logout"

  get '/order' , to: 'sessions#index', as: 'order'
  post '/order' , to: 'sessions#create', as: 'add_to_order'
  patch '/order' , to: 'sessions#update', as: 'update_order'
  delete '/order' , to: 'sessions#destroy', as: 'delete_order'

  get '/order/:id' , to: 'orders#show', as: 'order_details'

  # post '/orderitem' , to: 'order_items#create', as: 'create_order'

  resources :orders, only: [:index, :new, :create]

  resources :products do
    resources :reviews, only: [:create, :new]
  end

  resources :categories, only: [:index, :create, :new, :show]

  resources :order_items, only: [:index, :show, :create, :edit, :update]

  resources :users do
    resources :products, except: [:delete]
    resources :order_items, only: [:index]
  end

end
