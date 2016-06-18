Rails.application.routes.draw do
  root to: 'work_sites#index'

  resources :work_sites, only: [:show] do
    resources :check_ins, only: [:new, :create]
  end
end
