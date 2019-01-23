Rails.application.routes.draw do
  resources :post_categories
  resources :categories
  resources :posts
  resources :users
  resources :comments
  resources :likes
  resources :follows

  get "/signup", to: "users#new", as: "signup"
  post '/users', to: "users#create"
  get "/users/:id/follow", to: "users#follow", as: "follows_with"
  # our login logic
  get "/feed", to: "posts#feed", as: "feed"

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create", as: "sessions"

  delete "sessions", to: "sessions#destroy"
end
