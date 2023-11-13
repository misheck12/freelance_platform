class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    # Logic for regular users' dashboard
    if current_user.client?
      @tasks = current_user.tasks_as_client
    elsif current_user.freelancer?
      @tasks = current_user.tasks_as_freelancer
    elsif current_user.admin?
      redirect_to admin_dashboard_path # Redirect admin users to the admin dashboard
    end
  end

  def admin
    # Ensure only admins can access this page
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
      return
    end

    # Fetch only payments that are pending approval
    @pending_payments = Payment.where(status: :pending_approval)
  end
end
