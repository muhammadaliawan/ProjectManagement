class Admin::ProjectsController < ProjectsController

  def index
    @projects = Project.all
  end
  
end
