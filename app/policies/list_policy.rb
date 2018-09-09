class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
  def create?
    return true
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

  def edit_retail?
    is_owner?
  end

  def edit_wholesale?
    is_owner?
  end

  def edit_purchase?
    is_owner?
  end

  def show?
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  private

  def is_owner?
    user == record.user
  end

end
