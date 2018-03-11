Rails.application.routes.draw do

  root "welcome#index"

  resources :appointments
  resources :providers
  resources :users

  resources :welcome



match 'auth/:provider/callback', to: 'sessions#create_from_omniauth', via: [:get, :post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]
match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  