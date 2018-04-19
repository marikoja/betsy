Rails.application.routes.draw do

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'

  root 'products#index'

  resources :sessions

  resources :products

  resources :categories

  resources :carts

  resources :reviews

  resources :users

  resources :order_items
end
