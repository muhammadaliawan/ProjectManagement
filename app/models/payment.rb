# frozen_string_literal: true

class Payment < ApplicationRecord
  paginates_per 5

  belongs_to :project

  validates :details, :date, presence: true
  validates :amount, numericality: { other_than: 0 }

  after_create :add_project_payment
  after_destroy :remove_project_payment
  after_update :update_project_payment

  def self.monthly_payments
    Payment.group_by_month(:date).sum(:amount)
  end

  private

  def add_project_payment
    project.total_payments = project.total_payments.to_i + amount
    project.save
  end

  def remove_project_payment
    project.total_payments = project.total_payments.to_i - amount
    project.save
  end

  def update_project_payment
    difference = amount - amount_before_last_save
    project.total_payments = project.total_payments.to_i + difference
    project.save
  end
end
