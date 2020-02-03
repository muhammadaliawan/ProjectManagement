# frozen_string_literal: true

class TimeLog < ApplicationRecord
  paginates_per 5

  belongs_to :user
  belongs_to :project

  validates :start_time, :end_time, :task, presence: true
  validate :start_time_cannot_be_greater_than_end_time

  private

  def start_time_cannot_be_greater_than_end_time
    return unless (start_time.present? && end_time.present?) || start_time > end_time

    errors.add(:start_time, 'cannot be greater then end time!')
    errors.add(:end_time, 'cannot be less then start time!')
  end
end
