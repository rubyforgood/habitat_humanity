Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], path: ''

  # redirects to login page if user is not authenticated
  authenticate :user do
    namespace :admin do
      resources :users
      resources :work_sites do
        post '/activation', action: :activate
        delete '/activation', action: :deactivate
      end
      resources :volunteers
      resources :shifts
      resources :report_recipients
      resources :shift_events
      root to: 'shifts#index'
    end
  end

  scope :admin do
    resource :signatures_report, only: [:show]
    resource :hours_report,      only: [:show], defaults: { format: :csv }
  end

  # unavailable if user is not authenticated
  authenticated :user do
    root to: 'admin/shifts#index', as: :authenticated_root
  end

  resources :check_ins, only: %i[new create]

  root to: 'check_ins#new'
end
