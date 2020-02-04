# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5

  belongs_to :project

  validates :details, :date, presence: true
  validates :amount, numericality: { other_than: 0 }

  after_create :add_in_project_payments
  before_destroy :remove_from_project_payments
  before_update :save_previous_amount
  after_update :update_project_payments

  private

  def save_previous_amount
    id = self.id
    @old_amount = project.payments.find(id).amount
  end

  def add_in_project_payments
    @total_payments = project.total_payments
    @total_payments = @total_payments.to_i + amount
    project.total_payments = @total_payments
    project.save
  end

  def remove_from_project_payments
    @total_payments = project.total_payments
    @total_payments = @total_payments.to_i - amount
    project.total_payments = @total_payments
    project.save
  end

  def update_project_payments
    @difference = amount - @old_amount
    @total_payments = project.total_payments
    @total_payments = @total_payments.to_i + @difference
    project.total_payments = @total_payments
    project.save
  end
end
