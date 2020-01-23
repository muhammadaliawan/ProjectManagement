# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def index?
    user.id == record.id
  end

  def show?
    user.id == record.id
  end
end
