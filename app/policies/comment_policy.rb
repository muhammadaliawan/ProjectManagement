# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def new?
    user.admin? || record.commentable.manager == user
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
