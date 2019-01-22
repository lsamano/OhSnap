Rails.application.routes.draw do
  resources :post_categories
  resources :categories
  resources :posts
  resources :users
  resources :comments
  resources :likes

  get "/signup", to: "users#new", as: "signup"
  post '/users', to: "users#create"
  # our login logic
  get "/feed", to: "posts#feed", as: "feed"

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create", as: "sessions"

  delete "sessions", to: "sessions#destroy"
end
