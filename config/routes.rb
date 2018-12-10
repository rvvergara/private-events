Rails.application.routes.draw do
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
  resources :users
end
