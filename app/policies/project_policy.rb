# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    user.admin? || record.manager == user || record.created_by == user || record.resources.include?(user)
  end

  def new?
    user.admin? || user.manager?
  end

  def edit?
    user.admin? || user.manager?
  end

  def create?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end

  def destroy?
    user.admin? || user.manager?
  end

  def search
    user.admin? || user.manager?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
