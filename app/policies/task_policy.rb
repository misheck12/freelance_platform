class TaskPolicy < ApplicationPolicy
  # Define user's ability to view the task
  def show?
    user.admin? || record.client == user || (user.freelancer? && record.freelancer == user)
  end

  # Define user's ability to create a task
  def create?
    user.client?
  end

  # Define user's ability to update the task
  def update?
    user.admin? || record.client == user
  end

  # Define user's ability to delete the task
  def destroy?
    user.admin? || record.client == user
  end

  # Scope to determine which tasks a user can view in a list
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.client?
        scope.where(client: user)
      elsif user.freelancer?
        scope.where(freelancer: user)
      else
        scope.none
      end
    end
  end
end
