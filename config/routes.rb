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
  Rails.application.routes.draw do
    # ... other routes ...
  
    resources :tasks do
      member do
        post 'accept'
        post 'complete'
      end
  
      resources :reviews, only: [:new, :create]
      
      # Nesting payments inside tasks
      resources :payments, only: [:new, :create, :show]
    end
  
    # If you have independent payment routes, you might want to remove or adjust them
    # resources :payments, only: [:new, :create, :show]
  
    resources :reviews, only: [:show, :edit, :update, :destroy]
  
    # ... other routes ...
  end
  
end
