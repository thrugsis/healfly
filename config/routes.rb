Rails.application.routes.draw do

resources :providers do
	resources :appointments
end
  resources :providers
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
