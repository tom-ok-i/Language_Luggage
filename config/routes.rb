Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about'

  resources:users,only:[:index,:show,:edit,:update]
end
