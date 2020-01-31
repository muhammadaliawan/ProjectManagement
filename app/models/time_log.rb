# frozen_string_literal: true

class TimeLog < ApplicationRecord
  paginates_per 5

  belongs_to :user
  belongs_to :project

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :task, presence: true
  validate :start_time_cannot_be_greater_than_end_time

  private

  def start_time_cannot_be_greater_than_end_time
    return unless start_time.present? && end_time.present?

    errors.add(:start_time, 'cannot be greater then end time!') if start_time > end_time
  end
end
