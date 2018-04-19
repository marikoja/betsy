Rails.application.routes.draw do
  get 'categories/index'

  get 'categories/new'

  get 'categories/create'

  get 'categories/edit'

  get 'categories/update'

  get 'categories/show'

  get 'categories/destroy'

  get 'products/index'

  get 'products/new'

  get 'products/create'

  get 'products/edit'

  get 'products/update'

  get 'products/show'

  get 'products/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
