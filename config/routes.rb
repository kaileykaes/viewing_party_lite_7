Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'landing#index'

  get "/register", to: 'users#new', as: 'register'

  resources :users, only: [:create, :show] do 
    resources :discover, only: [:index]
    resources :movies, only: [:index]
  end

  get '/register', to: 'users#new'
end
