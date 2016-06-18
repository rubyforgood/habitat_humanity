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

  root to: 'check_ins#new'

  resources :check_ins, only: [:new, :create]
end
