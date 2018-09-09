class DetailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    return true
  end

  def new?
    return true
  end

  def destroy?
    is_owner?
  end

  private

  def is_owner?
    user == record.user
  end

end
