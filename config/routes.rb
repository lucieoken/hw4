Rails.application.routes.draw do
  root 'places#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :places
  resources :entries

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
