Rails.application.routes.draw do
  # Define root path
  root 'dashboard#show'

  # Dashboard routes
  get 'dashboard/show'
  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  # Devise routes for user authentication with custom controllers for registrations
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Custom routes within Devise for handling special user registration flows
  devise_scope :user do
    get 'users/new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'users/create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :admin_destroy_user
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  # Routes for tasks, with custom member routes for 'accept' and 'complete' actions
  resources :tasks do
    member do
      post 'accept'  # Defines the route for the 'accept' action on individual tasks
      post 'complete'  # Defines the route for the 'complete' action on individual tasks
    end

    # Nested reviews routes under tasks for 'new' and 'create' actions
    resources :reviews, only: [:new, :create]
  end
  
  # Routes for payments
  resources :payments, only: [:new, :create, :show]

  # Independent routes for reviews, excluding 'new' and 'create'
  # as they are already defined within the nested resources
  resources :reviews, only: [:show, :edit, :update, :destroy]

  # Any additional routes can be added below
  # Make sure there is no extra 'end' below this comment
end
