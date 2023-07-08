# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'landing#index'

  get '/register', to: 'users#new', as: 'register'

  resources :users, only: %i[create show] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show]
  end

  get '/register', to: 'users#new'
end
