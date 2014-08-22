Rails.application.routes.draw do
  root to: 'places#index'

  get :status, to: 'application#status'
  resources :places, except: [:show]
  resources :shops, only: [:create, :destroy]
end
