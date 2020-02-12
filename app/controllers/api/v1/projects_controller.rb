# frozen_string_literal: true

class Api::V1::ProjectsController < Api::ApiController
  before_action :user_authentication, only: %i[create update destroy]
  before_action :set_project, only: %i[show update destroy]

  def index
    @projects = Project.fetch_current_user_projects(current_user)
    success_response(@projects)
  end

  def show
    success_response(@project)
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      success_response(@project, :created)
    else
      failure_response(@project.errors)
    end
  end

  def update
    if @project.update(project_params)
      success_response(@project, :updated)
    else
      failure_response(@project.errors)
    end
  end

  def destroy
    if @project.destroy
      success_response(@project, :deleted)
    else
      failure_response(@project.errors)
    end
  end

  private

  def set_project
    @project = Project.fetch_current_user_projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, :total_payments, :hours_logged, :created_by_id, :manager_id, :client_id)
  end
end
