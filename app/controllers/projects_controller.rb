# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @clients = Client.order(:name)
  end

  def show; end

  def edit
    @clients = Client.order(:name)
  end

  def create
    @client = Client.find(params[:project][:client])
    @project = Project.new(project_params)
    @project.client = @client

    if @project.save
      redirect_to manager_project_path(@project), notice: 'Project created successfully.'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project successfully deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, :total_paymentss, :time_log)
  end
end
