class TaskPolicy < ApplicationPolicy
  # Define user's ability to view the task
  def show?
    user_is_admin_or_owner? || (user.freelancer? && record.freelancer == user)
  end

  # Define user's ability to create a task
  def create?
    user&.client?
  end

  # Define user's ability to update the task
  def update?
    user_is_admin_or_owner?
  end

  # Define user's ability to delete the task
  def destroy?
    user_is_admin_or_owner?
  end

  # Scope to determine which tasks a user can view in a list
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.nil?
        scope.none
      elsif user.admin?
        scope.all
      elsif user.client?
        scope.where(client: user)
      elsif user.freelancer?
        # Freelancers can see tasks assigned to them and open tasks
        scope.where(freelancer: user).or(scope.where(status: :open))
      else
        scope.none
      end
    end
  end

  private

  def user_is_admin_or_owner?
    user&.admin? || record.client == user
  end
end
