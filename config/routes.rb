Rails.application.routes.draw do

  get 'events/new'
  get 'events/edit'
  root 'static_pages#home'

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  
  resources :users do
    resources :events
  end
end
