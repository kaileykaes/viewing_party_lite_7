# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'landing#index'

  get '/register', to: 'users#new', as: 'register'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login', as: 'user_login'
    
  resources :users, only: [:create, :show] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show]
    resources :viewing_parties, only: [:new, :create]
  end

  get '/register', to: 'users#new'
end
