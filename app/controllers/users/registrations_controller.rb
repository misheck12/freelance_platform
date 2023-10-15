class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :ensure_admin, only: [:new_freelancer, :create_freelancer]

  # GET /users/sign_up
  def new
    super  # This calls Devise's default new method
  end

  # POST /users
  def create
    super  # This calls Devise's default create method
  end

  # GET /users/new_freelancer
  def new_freelancer
    build_resource({})
    respond_with self.resource
  end

  # POST /users/create_freelancer
  def create_freelancer
    build_resource(sign_up_params.merge(role: :freelancer))

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end

  private

  def ensure_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
