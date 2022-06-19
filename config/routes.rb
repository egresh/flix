Rails.application.routes.draw do
  resources :users
  root "movies#index"

  get "signup" => "users#new"
  get "signin" => "sessions#new"

  get "movies/filter/:filter" => "movies#index", :as => :movies_filter

  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    get 'movie/:slug' => "movies#show", as: :slug
    resources :reviews
    resources :favorites
  end

  resources :genres
end
