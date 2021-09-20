Rails.application.routes.draw do
  get 'users/:id/favorites' => 'users#favorites'
  get 'genres/show/:genre_id', to: 'genres#show', as: 'genre'
  get 'searches/search'
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as:  'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get '/search', to: 'searches#search'

end