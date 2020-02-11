# frozen_string_literal: true

class Api::V1::TimeLogsController < Api::ApiController
  def index
    @time_logs = TimeLog.all
    success_response(@time_logs, :ok)
  end

  def show
    @project = Project.find(params[:project_id])
    @time_log = @project.time_logs.find(params[:id])
    success_response(@time_log, :ok)
  end
end
