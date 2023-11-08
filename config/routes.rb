Rails.application.routes.draw do
  root 'dashboard#show'

  get 'dashboard/show'
  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'users/new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'users/create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :admin_destroy_user
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :tasks do
    member do
      post 'accept'
      post 'complete'
    end

    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:show, :edit, :update, :destroy]

end
