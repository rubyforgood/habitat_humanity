Rails.application.routes.draw do
  resources :check_ins, only: [:new, :create]

  root to: "work_sites#index"

  resources :work_sites, only: [:show]
end
