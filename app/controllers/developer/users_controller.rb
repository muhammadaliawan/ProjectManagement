class Developer::UsersController < UsersController

  before_action :set_developer, only: [:show, :edit, :update, :destroy]

  def index
    @clients = User.where(role: 'client')
    @projects = Project.where(id: current_user.id)
    @time_logs = TimeLog.where(id: current_user.id)
    

    @developers = User.where(id: current_user.id)
  end

  def show

  end

  def new
    @developer = Developer.new
  end

  def create
  end

  def edit
  end

  def update
    respond_to do |format|
      if @developer.update(developer_user_params)
        format.html { redirect_to developer_users_url, notice: 'Your Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destory
  end


  private

  def set_developer
    @developer = User.find(params[:id])
  end

  def developer_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role)
  end
end
