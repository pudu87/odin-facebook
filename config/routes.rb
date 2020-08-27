Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'},
             :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'posts#index'

  resources :users, only: [:index, :show] do
    resources :profiles, only: [:edit, :update]
    member do
      get "edit_name"
      post "update_name"
    end
  end
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts, except: [:show, :new] do
    resources :comments, only: [:create, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end
