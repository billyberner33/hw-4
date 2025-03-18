Rails.application.routes.draw do
  root "places#index"

  # User Authentication
  get "/login", to: "sessions#new", as: "login"
  post "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # Resources
  resources :users, only: [:new, :create]
  resources :places do
    resources :entries, only: [:new, :create, :index]
  end
end
