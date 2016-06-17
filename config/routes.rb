Rails.application.routes.draw do
  resources :check_ins, only: [:new, :create]
end
