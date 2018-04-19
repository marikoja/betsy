Rails.application.routes.draw do

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'

<<<<<<< HEAD
  # resources :sessions
  #
  # resources :products
  #
  # resources :categories
  #
  # resources :carts
  #
  # resources :reviews

  resources :users do
    resources :orders
    resources :products
  end

  # resources :order_items
=======
  root 'products#index'

  resources :sessions

  resources :products

  resources :categories

  resources :carts

  resources :reviews

  resources :users

  resources :order_items
>>>>>>> a05701ef1fbecdcf3166ea3ca454ab3b3286871d
end
