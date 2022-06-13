Rails.application.routes.draw do
  resources :users
  root "movies#index"

  get "signup" => "users#new"
  get "signin" => "sessions#new"

  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews
  end
end
