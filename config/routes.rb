Rails.application.routes.draw do
  root to: 'places#index'
  resources :places, except: [:show]
  resources :shops, only: [:create, :destroy]
end
