class TagPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    logged_in?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
