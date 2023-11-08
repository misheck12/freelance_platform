Rails.application.routes.draw do
  root 'dashboard#show'

  get 'dashboard/show'

  # Devise routes with custom controllers
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Custom routes for freelancer registration by admin within Devise scope
  devise_scope :user do
    get 'users/new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'users/create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :admin_destroy_user
  end

  # Task and nested reviews routes
  resources :tasks do
    member do
      post 'accept'
      post 'complete'
    end
    resources :reviews, only: [:new, :create] # Nested reviews under tasks
  end

  # You may also need to show, edit, update, or destroy reviews independently of tasks
  resources :reviews, only: [:show, :edit, :update, :destroy]

  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
