class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private

  def logged_in?
    user.present?
  end

  def belongs_to_user?
    return false unless logged_in?
    return true if user.admin? #       as opposed to record&.user_id, in case user is delegated
    record.is_a?(User) ? user == record : user.id == record&.user&.id
  end
end
