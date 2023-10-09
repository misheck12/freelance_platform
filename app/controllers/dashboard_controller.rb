class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.client?
      @tasks = current_user.tasks_as_client
    elsif current_user.freelancer?
      @tasks = current_user.tasks_as_freelancer
    end
  end
end
