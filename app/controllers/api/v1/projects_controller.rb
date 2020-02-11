# frozen_string_literal: true

class Api::V1::ProjectsController < Api::ApiController
  before_action :set_project, only: %i[show update destroy]
  before_action :user_authentication, only: %i[create update destroy]

  def index
    @projects = Project.all
    success_response(@projects, :ok)
  end

  def show
    @project = Project.find(params[:id])
    success_response(@project, :ok)
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      success_response(@project, :created)
    else
      render json: @project.errors
    end
  end

  def update
    if @project.save
      success_response(@project, :updated)
    else
      render json: @project.errors
    end
  end

  def destroy
    @project.destroy

    if @project.destroy
      success_response(@project, :deleted)
    else
      render json: @project.errors
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, :total_payments, :hours_logged, :created_by_id, :manager_id, :client_id)
  end
end
