Rails.application.routes.draw do
  get 'dashboard/show'

  # Standard Devise routes
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Custom routes for Devise within a user scope
  devise_scope :user do
    get 'users/new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'users/create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :admin_destroy_user
  end
    
  resources :tasks
  resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy]

  get 'dashboard', to: 'dashboard#show', as: 'dashboard'
end
