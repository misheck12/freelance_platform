Rails.application.routes.draw do
  get 'dashboard/show'
  devise_for :users
  resources :tasks
  resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy]
end
