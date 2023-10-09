class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :ensure_admin, only: [:new_freelancer, :create_freelancer]
  
    def new_freelancer
      @user = User.new
    end
  
    def create_freelancer
      @user = User.new(sign_up_params.merge(role: :freelancer))
      if @user.save
        redirect_to root_path, notice: 'Freelancer was successfully created.'
      else
        render :new_freelancer
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
  