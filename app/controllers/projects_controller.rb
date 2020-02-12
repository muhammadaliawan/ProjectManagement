# frozen_string_literal: true

class ProjectsController < ApplicationController
  include ProjectHelper

  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_clients, :set_managers, only: %i[new edit]

  def index
    @projects = Project.fetch_current_user_projects(current_user)
    @projects = Project.search_projects(current_user, params) if params[:search]
    @projects = @projects.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project = Project.new
    authorize @project
  end

  def show
    authorize @project
    @payments = @project.payments.page(params[:payment_page])
    @time_logs = @project.time_logs.page(params[:time_log_page])
    @attachments = @project.attachments.page(params[:attachment_page])
    @comments = @project.comments

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save!
      redirect_to generic_path_method('show', 'project', @project), notice: 'Project created successfully.'
    else
      render :new
    end
  end

  def update
    authorize @project

    if @project.update(project_params)
      redirect_to generic_path_method('show', 'project', @project), notice: 'Project successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @project

    @project.destroy
    redirect_to generic_path_method('index', 'project', @projects), notice: 'Project successfully deleted.'
  end

  private

  def set_managers
    @managers = User.managers.order(:name)
  end

  def set_clients
    @clients = Client.order(:name)
  end

  def set_project
    @project = Project.fetch_current_user_projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, :client_id, :manager_id, resource_ids: [])
  end
end
