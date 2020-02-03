# frozen_string_literal: true

class PaymentPolicy < ApplicationPolicy
  def new?
    user.admin? || record.project.manager == user
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
