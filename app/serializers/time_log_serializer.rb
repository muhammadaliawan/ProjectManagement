# frozen_string_literal: true

class TimeLogSerializer < ApplicationSerializer
  attributes :start_time, :end_time, :task

  belongs_to :user
  belongs_to :project
end
