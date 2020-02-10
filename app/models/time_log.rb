# frozen_string_literal: true

class TimeLog < ApplicationRecord
  paginates_per 5

  belongs_to :user
  belongs_to :project

  validates :start_time, :end_time, :task, presence: true
  validate :start_time_cannot_be_greater_than_end_time

  after_create :add_project_time_log
  after_destroy :remove_project_time_log
  after_update :update_project_time_log

  def self.monthly_time_logs
    TimeLog.group_by_month(:start_time).sum(self.total_hours_logged)
  end

  private

  def self.total_hours_logged
    total_hours = 0
    all.each do |time_log|
      total_hours = ((time_log.end_time - time_log.start_time) / 60 / 60).to_i
    end
    total_hours
  end

  def start_time_cannot_be_greater_than_end_time
    return unless (start_time.present? && end_time.present?) && start_time > end_time

    errors.add(:start_time, 'cannot be greater then end time!')
    errors.add(:end_time, 'cannot be less then start time!')
  end

  def add_project_time_log
    total_time = ((end_time - start_time) / 60 / 60).to_i
    project.hours_logged = project.hours_logged.to_i + total_time
    project.save
  end

  def remove_project_time_log
    total_time = ((end_time - start_time) / 60 / 60).to_i
    project.hours_logged = project.hours_logged.to_i - total_time
    project.save
  end

  def update_project_time_log
    previous_total_time = ((end_time_before_last_save - start_time_before_last_save) / 60 / 60).to_i
    total_time = ((end_time - start_time) / 60 / 60).to_i
    difference = total_time - previous_total_time
    project.hours_logged = project.hours_logged.to_i + difference
    project.save
  end
end
