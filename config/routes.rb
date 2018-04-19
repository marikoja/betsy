Rails.application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  resources :product

  resources :category

  resources :cart

  resources :review

  resources :user 

  resources :order_item
end
