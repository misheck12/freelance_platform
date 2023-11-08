Rails.application.routes.draw do
  # Define root path
  root 'dashboard#show'

  # Dashboard routes
  get 'dashboard/show'
  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  # Devise routes with custom controllers for user sessions and registrations
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Custom routes within Devise for handling specific user roles like freelancer registration by admin
  devise_scope :user do
    get 'users/new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'users/create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :admin_destroy_user
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  # Task routes with custom member routes for actions like accept and complete
  resources :tasks do
    member do
      post 'accept'
      post 'complete'
    end

    # Nested reviews routes under tasks for new and create actions
    resources :reviews, only: [:new, :create]
  end

  # Independent reviews routes for other actions
  resources :reviews, except: [:new, :create]

  # Any other routes...
end
