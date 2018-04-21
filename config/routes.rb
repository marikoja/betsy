Rails.application.routes.draw do

  root 'products#index'

  get '/order', to: 'orders#index', as: 'order'

  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'
  delete '/logout', to: "users#destroy", as: "logout"


  resources :sessions

  resources :products

  resources :categories

  # resources :orders

  resources :users do
    resources :products, except: [:delete]
    resources :orders, only: [:index, :show]
    resources :order_items, only: [:index]
  end

end
