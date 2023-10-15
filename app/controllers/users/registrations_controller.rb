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

    def destroy
      # Find the user
      user = User.find(params[:id])
  
      # Check if the current user is an admin and the user to delete is not an admin
      if current_user.admin? && !user.admin?
        user.destroy
        redirect_to some_path, notice: 'User was successfully deleted.'
      else
        redirect_to some_path, alert: 'You cannot delete this user.'
      end
    end
    

    protected

    def require_no_authentication
      if current_user && !current_user.admin?
        flash[:alert] = "You are already signed in."
        redirect_to root_path
      end
      # Do not call the parent implementation, to avoid the redirection
    end
  
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :role])
    end    
  
    private
  
    def ensure_admin
      unless current_user&.admin?
        redirect_to root_path, alert: 'You are not authorized to perform this action.'
      end
    end
  end
  