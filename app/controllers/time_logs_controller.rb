# frozen_string_literal: true

class TimeLogsController < ApplicationController
  before_action :set_project
  before_action :set_time_log, only: %i[edit update destroy]

  def new
    @time_log = @project.time_logs.new
    authorize @time_log
  end

  def edit
    authorize @time_log
  end

  def create
    @time_log = @project.time_logs.new(time_log_params)
    @time_log.user = current_user
    authorize @time_log
    @success = @time_log.save
  end

  def update
    authorize @time_log
    @time_log.update(time_log_params)
  end

  def destroy
    authorize @time_log
    @success = @time_log.destroy
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_time_log
    @time_log = @project.time_logs.find(params[:id])
  end

  def time_log_params
    params.require(:time_log).permit(:start_time, :end_time, :date, :task)
  end
end
