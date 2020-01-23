# frozen_string_literal: true

class Manager::ClientPolicy < ClientPolicy
  def new?
    user.manager?
  end

  def edit?
    user.manager?
  end

  def create?
    user.manager?
  end

  def update?
    user.manager?
  end

  def destroy?
    user.manager?
  end
end
