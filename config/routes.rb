Rails.application.routes.draw do
  get 'dashboard/show'

  # Devise routes with custom controllers
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Custom routes for freelancer registration by admin within Devise scope
  devise_scope :user do
    get 'users/new_freelancer', to: 'users/registrations#new_freelancer', as: :new_freelancer_registration
    post 'users/create_freelancer', to: 'users/registrations#create_freelancer', as: :create_freelancer_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :admin_destroy_user
  end

  # Other application routes
  resources :tasks
  resources :reviews, only: [:show, :new, :create, :edit, :update, :destroy]

  get 'dashboard', to: 'dashboard#show', as: 'dashboard'

  # It seems you have this route for user deletion, but it might conflict with Devise's own routes.
  # If you have a custom method for user deletion outside of Devise, consider renaming the route/path.
  # resources :users, only: [:destroy] # Consider commenting out or removing this line if it's not used elsewhere.
end
