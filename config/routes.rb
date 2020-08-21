Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}

  root to: 'users#index'

  resources :users, only: [:index, :show] do
    resources :profiles, only: [:edit, :update]
  end
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts, except: [:show] do
    resources :comments, only: [:create, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end
