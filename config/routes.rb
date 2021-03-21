Rails.application.routes.draw do
  root 'toppages#index'

  get '/login', to:  "sessions#new"
  post 'login', to:  "sessions#create"
  delete 'logout', to: "sessions#destroy"
  
  namespace :admin do
    resources :users
  end

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users, only: [:show, :edit, :update]

  resources :posts
end
