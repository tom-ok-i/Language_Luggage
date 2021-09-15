Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about'

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
