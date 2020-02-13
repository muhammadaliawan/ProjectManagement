# frozen_string_literal: true

class Api::V1::TimeLogsController < Api::ApiController
  before_action :set_project
  before_action :set_time_log, only: %i[show update destroy]
  
  def index
    @time_logs = TimeLog.all
    authorize @time_logs, policy_class: TimeLogPolicy
    success_response(@time_logs)
  end

  def show
    authorize @time_log, policy_class: TimeLogPolicy
    success_response(@time_log)
  end

  def create
    @time_log = @project.time_logs.new(time_log_params)
    authorize @time_log, policy_class: TimeLogPolicy

    if @time_log.save
      success_response(@time_log, :created)
    else
      failure_response(@time_log.errors)
    end
  end

  def update
    authorize @time_log, policy_class: TimeLogPolicy

    if @time_log.update(time_log_params)
      success_response(@time_log, :updated)
    else
      failure_response(@time_log.errors)
    end
  end

  def destroy
    authorize @time_log, policy_class: TimeLogPolicy

    if @time_log.destroy
      success_response(@time_log, :deleted)
    else
      failure_response(@time_log.errors)
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_time_log
    @time_log = @project.time_logs.find(params[:id])
  end

  def time_log_params
    params.require(:time_log).permit(:start_time, :end_time, :task)
  end
end
