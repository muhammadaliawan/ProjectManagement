# frozen_string_literal: true

class Api::V1::ProjectsController < Api::ApiController
  before_action :set_project, only: %i[show update destroy]

  def index
    @projects = Project.all

    render json: @projects, status: 200
  end

  def show
    @project = Project.find(params[:id])

    render json: @project, status: 200
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, message: 'Project Created', status: 200
    else
      render json: @project.errors
    end
  end

  def update
    if @project.save
      render json: @project, message: 'Project Updated', status: 200
    else
      render json: @project.errors
    end
  end

  def destroy
    @project.destroy

    if @project.destroy
      render json: 'Project Deleted', status: 200
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
