class ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)
    # raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def index?
    basic_auth
  end

  def show?
    false
  end

  def create?
    basic_auth
  end

  def new?
    create?
  end

  def update?
    basic_auth
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def basic_auth
    user.superman? or user.admin?
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
end
