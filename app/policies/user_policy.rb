# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin? || (user.id == record.id)
  end

  def update?
    user.admin? || (user.id == record.id)
  end

  def destroy?
    user.admin?
  end

  def search?
    user.admin?
  end

  def edit_password?
    user.id == record.id
  end

  def update_password?
    user.id == record.id
  end

  def enable_disable_user?
    user.admin?
  end
end
