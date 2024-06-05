Rails.application.routes.draw do
  resources :entries
  resources :places
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  # Login/logout
  get("/login", { :controller => "sessions", :action => "new" })
  get("/logout", { :controller => "sessions", :action => "destroy" })
  post("/login", { :controller => "sessions", :action => "create" })

  # Define the root route
  get("/", { :controller => "places", :action => "index" })
end
