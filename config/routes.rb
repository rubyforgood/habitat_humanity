Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    namespace :admin do
      resources :users
      resources :work_sites
      resources :volunteers
      resources :shifts
      # resources :shift_events ### not needed for this app

      root to: 'shifts#index'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: 'work_sites#index'

  resources :work_sites, only: [:show] do
    resources :check_ins, only: [:new, :create]
  end
end
