# frozen_string_literal: true

class TimeLogPolicy < ApplicationPolicy
  def new?
    user.admin? || record.project.manager == user || record.user == user
  end

  def create?
    new? || record.commenter == user
  end

  def edit?
    new? || record.commenter == user
  end

  def update?
    new? || record.commenter == user
  end

  def destroy?
    new? || record.commenter == user
  end
end
