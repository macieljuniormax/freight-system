Rails.application.routes.draw do
  root  to: 'home#index'
  resources :carriers, only: [:index, :show, :new, :create]

end
