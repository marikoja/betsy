Rails.application.routes.draw do

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"
  get '/auth/github', as: 'github_login'

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
