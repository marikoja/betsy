Rails.application.routes.draw do

  root 'products#index'

  resources :product

  resources :category

  resources :cart

  resources :review

  resources :user

  resources :order_item
end
