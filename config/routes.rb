Rails.application.routes.draw do

  root "welcome#index"

  resources :appointments
  resources :providers
  resources :users
  resources :welcome

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  