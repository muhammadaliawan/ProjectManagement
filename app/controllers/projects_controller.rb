class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @client = User.find(params[:id])
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    @client = User.find(params[:id])
    @project.users << @client

    if @project.save
      redirect_to show_client_manager_user_path(@client), notice: 'Project created successfully' 
    else
      render edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details, :earnings, :time_log)
  end
end
