Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about'

  resources:users,only:[:index,:show,:edit,:update]
  resources:posts,only:[:new,:creatre,:index,:show,:edit,:destroy]

end
