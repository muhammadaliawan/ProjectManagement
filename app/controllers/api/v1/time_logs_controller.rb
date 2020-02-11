# frozen_string_literal: true

class Api::V1::TimeLogsController < Api::APIController
  def index
    @time_logs = TimeLog.all

    render json: @time_logs, status: 200
  end

  def show
    @project = Project.find(params[:project_id])
    @time_log = @project.time_logs.find(params[:id])

    render json: @time_log, status: 200
  end
end
