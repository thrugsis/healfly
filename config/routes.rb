Rails.application.routes.draw do

resources :providers do
	resources :appointments
end
  root "welcome#index"

  resources :appointments
  resources :providers
  resources :patients

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
      
      
  end

  #get "/sign_in" => "clearance/sessions#new", as: "sign_in" 

  #WIP:
  get '/providers/:id/profile', to: 'providers#profile', as: 'provider_profile'
  
  get '/sign_in', to: 'users#new', as: nil
  get "/sign_in/user" => "sessions#user_sign_in", as: "user_sign_in"
  get "/sign_in/provider" => "sessions#provider_sign_in", as: "provider_sign_in"

  get "/sign_in/user_login_success" => "sessions#user_login_success", as: "user_login_success"

  #SIGN OUT OVERRIDE:
  delete "/sign_out" => "sessions#destroy", as: "sign_out"


  get "/sign_up" => "clearance/users#new", as: "sign_up"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  root "welcome#index"

  resources :welcome

  post "providers/search" => "providers#search", as: "search"


match 'auth/:provider/callback', to: 'sessions#create_from_omniauth', via: [:get, :post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]
match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  





