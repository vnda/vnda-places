Rails.application.routes.draw do
  root to: 'places#index'

  get :status, to: 'application#status'
  resources :places
  resources :states, only: [:index]
  resources :shops, only: [:create, :destroy]
end
