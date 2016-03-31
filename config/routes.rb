Rails.application.routes.draw do
  # most common routes
  root 'home#show', via: [:get]
  resource :athlete_dashboard, only: [:show]
  resource :setter_dashboard, only: [:show]
  post 'athlete_climb_logs/new', to: 'athlete_climb_logs#new', as: ''
  devise_for :user_accounts, skip: :all
  devise_scope :user_account do
    post 'sign_in', to: 'devise/sessions#create'
    delete 'sign_out', to: 'devise/sessions#destroy'
    post 'user_accounts', to: 'devise/registrations#create'
  end


  # all other resources alphabetically
  resources :athlete_climb_logs, only: [:new, :edit, :create, :update]
  resources :climbs, only: [:index]
  resources :climb_pickers, only: [:show]
  resource :current_role, only: [:update]
  resource :flash, only: [:show]
  resources :gyms, except: :destroy
  resource :nearby_gyms, only: [:show]
  resource :user, only: [:edit, :update]
end
