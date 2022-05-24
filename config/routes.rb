Rails.application.routes.draw do
  root  to: 'home#index'
  resources :carriers, only: [:show, :new, :create]

end
