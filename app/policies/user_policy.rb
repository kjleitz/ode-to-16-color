class UserPolicy < ApplicationPolicy
  def index?
    logged_in?
  end

  def show?
    logged_in?
  end

  def create?
    # only logged-out people and admins can sign up
    !logged_in? || user.admin?
  end

  def new?
    create?
  end

  def update?
    belongs_to_user?
  end

  def edit?
    update?
  end

  def destroy?
    belongs_to_user?
  end

  class Scope < Scope
    def resolve
      logged_in? ? scope.all : scope.none
    end
  end
end
