Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

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

  root to: 'check_ins#new'

  resources :check_ins, only: [:new, :create]

  resources :signatures_reports, only: [:index]
  resources :hours_reports, only: [:index], defaults: { format: :csv }
end
