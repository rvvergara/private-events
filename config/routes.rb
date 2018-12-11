Rails.application.routes.draw do
  root 'static_pages#home'

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  
  resources :users do
    resources :events, only: [:new, :edit, :create, :destroy]
  end
  
  resources :events, only: [:index, :show, :update]
end
