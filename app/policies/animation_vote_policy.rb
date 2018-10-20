class AnimationVotePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    return false unless logged_in?
    animation = record.animation
    user_id = user.id
    return false if user_id == animation.user_id # it's the user's own animation
    return false if animation.votes.pluck(:user_id).include?(user_id) # they've already voted
    true
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
      # TODO: this should probably include votes the user has received
      user.admin? ? scope.all : scope.where(user_id: user.id)
    end
  end
end
