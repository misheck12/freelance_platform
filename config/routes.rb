Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy]
end
