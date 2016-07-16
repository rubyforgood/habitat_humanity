Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  # redirects to login page if user is not authenticated
  authenticate :user do
    namespace :admin do
      resources :users
      resources :work_sites
      resources :volunteers
      resources :shifts
      resources :report_recipients
      resources :shift_events
      root to: 'shifts#index'
    end
  end

  # unavailable if user is not authenticated
  authenticated :user do
    root to: 'admin/shifts#index', as: :authenticated_root
  end

  resources :check_ins, only: [:new, :create]

  resources :signatures_reports, only: [:index]
  resources :hours_reports,      only: [:index], defaults: { format: :csv }

  root to: 'check_ins#new'
end
