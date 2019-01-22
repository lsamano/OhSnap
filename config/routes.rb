Rails.application.routes.draw do
  resources :post_categories
  resources :categories
  resources :posts
  resources :users

  get "/signup", to: "users#new", as: "signup"
  post '/users', to: "users#create"
  # our login logic
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create", as: "sessions"

  delete "sessions", to: "sessions#destroy"
end
