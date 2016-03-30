Rails.application.routes.draw do
  devise_for :user_accounts
  resources :gyms, except: :destroy
  root 'home#show', via: [:get]

  resource :user, only: [:edit, :update]

  resource :current_role, only: [:update]

  resources :athlete_climb_logs, only: [:new, :edit, :create, :update]
  post 'athlete_climb_logs/new', to: 'athlete_climb_logs#new', as: ''

  resources :climbs, only: [:index]

  resource :athlete_dashboard, only: [:show]

  resource :setter_dashboard, only: [:show]

  resource :nearby_gyms, only: [:show]

  resources :climb_pickers, only: [:show]

  resource :flash, only: [:show]
end
