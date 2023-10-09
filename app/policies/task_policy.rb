class TaskPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope
  
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  
    def resolve
      if user.admin?
        scope.all
      elsif user.freelancer?
        scope.where(freelancer: user)
      else
        scope.where(client: user)
      end
    end
  end
  
end
