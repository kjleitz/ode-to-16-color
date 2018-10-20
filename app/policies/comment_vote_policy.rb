class CommentVotePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    return false unless logged_in?
    comment = record.comment
    user_id = user.id
    return false if user_id == comment.user_id # it's the user's own comment
    return false if comment.votes.pluck(:user_id).include?(user_id) # they've already voted
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
