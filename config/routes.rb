Rails.application.routes.draw do
  devise_for :users

  root to: 'users#index'

  resources :users, only: [:index, :show]
  resources :friendships, only: [:create, :update, :destroy]
end
