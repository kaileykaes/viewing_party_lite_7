Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'landing#index'

  get "/register", to: 'users#new', as: 'register'
  get '/users/:id/movies', to: "user_movies#index"

  get 'users/:user_id/movies/:id', to: 'movies#show'

  resources :users, only: [:create, :show] do 
    resources :discover, only: [:index]
  end

  get '/register', to: 'users#new'
end
