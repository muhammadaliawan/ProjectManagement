class Manager::UsersController < UsersController

  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    @developers = User.where(role: 'manager')
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def set_manager
    @manager = User.find(params[:id])
  end

  def admin_user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role)
  end

end
