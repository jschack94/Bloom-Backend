Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :locations, only: [:index]
      resources :users
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      patch "/users", to: "users#update"


      mount ActionCable.server => '/cable'
    end
  end
end