class AnimationPolicy < ApplicationPolicy
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
      scope.all
    end
  end
end
