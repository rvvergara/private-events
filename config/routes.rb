Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/home'
  get 'sessions/new'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/edit'
  get 'users/create'
  get 'users/update'
  get 'users/destroy'

  
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  resources :users
end
