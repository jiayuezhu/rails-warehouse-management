class BuyerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
  def all_buyers?
    @buyers = Buyer.where(is_buyer: true).select { |buyer| buyer.user = user }
  end

  def all_sellers?
    @buyers = Buyer.where(is_buyer: false).select { |buyer| buyer.user = user }
  end

  def new_buyer?
    return true
  end
  def new_seller?
    return true
  end
  def edit_buyer?
    is_owner?
  end

  def edit_seller?
    is_owner?
  end

  def create?
    return true
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
