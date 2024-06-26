Rails.application.routes.draw do
  resources :services
  resources :orders
  get 'home/index'
  resources :sessions, only: [:create]
  get '/auth/:provider/callback', to: 'sessions#create_auth_user'
  get 'login', to: 'sessions#index'
  get 'user_login', to: 'sessions#new'
  get "logout", to: "sessions#destroy"
  get 'signup', to: 'users#new'
  resources :users, only: [:create, :update, :destroy]
  get 'dashboard', to: 'dashboard#index'

  root "home#index"
end
