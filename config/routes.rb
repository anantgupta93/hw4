Rails.application.routes.draw do
  root to: "places#index" # Define root route to places#index
  
  resources :places do
    resources :entries
  end

  resources :sessions
  resources :users

  # Login/logout routes
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"
end
