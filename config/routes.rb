Rails.application.routes.draw do
  devise_for :users
  root  to: 'home#index'
  resources :carriers, only: [:index, :show, :new, :create, :edit, :update]
  resources :vehicles, only: [:index, :new, :create]
  resources :prices, only: [:index, :new, :create]
  resources :deadlines, only: [:index, :new, :create, :edit, :update]
  resources :price_queries, only: [:index, :new, :create] do
    get 'search', on: :collection
  end
  resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    post 'approved', on: :member
    post 'disapproved', on: :member
    post 'finished', on: :member
  end
end
