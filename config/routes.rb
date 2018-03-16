Rails.application.routes.draw do

get '/:id/payment/new', to: "braintree#new", as: "braintree_new"
post '/:id/payment/checkout', to: "braintree#checkout", as: "braintree_checkout"

resources :providers do
	resources :appointments
end
  root "welcome#index"

  resources :appointments
  resources :patients

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
      
      
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/users/:id/verification" => "users#verification", as: "verification"
  post "/users/:id/verification" => "users#verification_submit", as: "verification_submit"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  root "welcome#index"

  resources :welcome

  post "/providers/search" => "providers#search", as: "search" 


match 'auth/:provider/callback', to: 'sessions#create_from_omniauth', via: [:get, :post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]
match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
  





