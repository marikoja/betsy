Rails.application.routes.draw do

  resources :product

  resources :category

  resources :cart

  resources :review

  resources :user 

  resources :order_item
end
