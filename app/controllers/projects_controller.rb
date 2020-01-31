# frozen_string_literal: true

class ProjectsController < ApplicationController
  include ProjectHelper

  before_action :set_project, only: %i[get_developers show edit update destroy]
  before_action :get_client, :get_manager, :get_developer, only: %i[new edit]

  def index
    @projects = Project.get_projects(current_user).page(params[:page])
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
      redirect_to path_method(:show, :project, @project), notice: 'Project created successfully.'
    else
      render :new
    end
  end

  def update
    authorize @project

    @client = Client.find(params[:project][:client])
    @manager = User.find(params[:project][:manager])
    @user = User.find(params[:project][:resources])
    @project.client = @client
    @project.manager = @manager
    @project.resources << @user

    if @project.update(project_params)
      redirect_to path_method(:show, :project, @project), notice: 'Project successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @project

    @project.destroy
    redirect_to path_method(:index, :project, @projects), notice: 'Project successfully deleted.'
  end

  private

  def get_developer
    @developers = User.developers
  end

  def get_manager
    @manager = User.managers.order(:name)
  end

  def get_client
    @clients = Client.order(:name)
  end

  def set_project
    @project = Project.includes(:payments, :time_logs, :comments).find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, :client_id, :manager_id, :created_by_id, resource_ids: [])
  end
end
