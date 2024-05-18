Rails.application.routes.draw do
  get 'home/index'
  resources :sessions, only: [:create]
  get '/auth/:provider/callback', to: 'sessions#create_auth_user'
  get 'login', to: 'sessions#new'
  get "logout", to: "sessions#destroy"
  get 'signup', to: 'users#new'
  resources :users, only: [:create, :update, :destroy]

  root "home#index"
end
