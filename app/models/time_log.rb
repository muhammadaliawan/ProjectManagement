# frozen_string_literal: true

class TimeLog < ApplicationRecord
  paginates_per 5

  belongs_to :user
  belongs_to :project

  validates :start_time, :end_time, :task, presence: true
  validate :start_time_cannot_be_greater_than_end_time

  after_create :add_in_project_time_logs
  before_destroy :remove_from_project_time_logs
  before_update :save_previous_time_log
  after_update :update_project_time_logs

  def self.this_month_time_logs
    TimeLog.group_by_month(:start_time).sum(self.difference_of_dates)
  end

  private

  def self.difference_of_dates
    @sum = -0
    @total = 0;
    all.each do |time_log|
      @sum = ((time_log.end_time - time_log.start_time) / 60 / 60).to_i
    end
    @total += @sum
  end

  def start_time_cannot_be_greater_than_end_time
    return unless (start_time.present? && end_time.present?) && start_time > end_time

    errors.add(:start_time, 'cannot be greater then end time!')
    errors.add(:end_time, 'cannot be less then start time!')
  end

  def save_previous_time_log
    id = self.id
    @old_start_time = project.time_logs.find(id).start_time
    @old_end_time = project.time_logs.find(id).end_time
  end

  def add_in_project_time_logs
    @total_time = ((end_time - start_time) / 60 / 60).to_i
    @hours_logged = project.hours_logged
    @hours_logged = @hours_logged.to_i + @total_time
    project.hours_logged = @hours_logged
    project.save
  end

  def remove_from_project_time_logs
    @total_time = ((end_time - start_time) / 60 / 60).to_i
    @hours_logged = project.hours_logged
    @hours_logged = @hours_logged.to_i - @total_time
    project.hours_logged = @hours_logged
    project.save
  end

  def update_project_time_logs
    @old_total_time = ((@old_end_time - @old_start_time) / 60 / 60).to_i
    @total_time = ((end_time - start_time) / 60 / 60).to_i
    @difference = @total_time - @old_total_time
    @hours_logged = project.hours_logged
    @hours_logged = @hours_logged.to_i + @difference
    project.hours_logged = @hours_logged
    project.save
  end
end
