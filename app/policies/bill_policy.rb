class BillPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
  def show?
    is_owner?
  end
  def new?
    return true
  end

  def create?
    return true
  end

  def update?
    is_owner?
  end
  def new_retail?
    return true
  end
  def new_wholesale?
    return true
  end
  def new_purchase?
    return true
  end
  private

  def is_owner?
    user == record.user
  end
end
