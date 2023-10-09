Rails.application.routes.draw do
  get 'dashboard/show'
  devise_for :users, controllers: { registrations: 'users/registrations' } do
    get 'new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
  end
    
  resources :tasks
  resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy]

  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

end
