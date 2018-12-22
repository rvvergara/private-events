Rails.application.routes.draw do
  get 'users_invite/show'
  root 'static_pages#home'

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  get "/invite/:user_id/:event_id", to: "users_invite#show", as: "add_invitees"
  
  resources :users do
    resources :events, only: [:new, :edit, :create, :destroy]
  end
  
  resources :events, only: [:index, :show, :update]

  resources :attendances, only: :create

  resources :invitations, only: [:new, :create]
end
