Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :locations, only: [:index]
      resources :users, only: [:index, :create, :current_user]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      patch "/users", to: "users#update"

      resources :connections, only: [:index, :create]
      patch "/connections", to: "connections#update"
      delete "/connections", to: "connectionss#destroy"

      resources :messages, only: [:create]
      
      resources :notifications, only: [:create]
      patch "/notifications", to: "notifications#update"

      mount ActionCable.server => '/cable'
    end
  end
  end


  
