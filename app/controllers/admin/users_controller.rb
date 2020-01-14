class Admin::UsersController < UsersController

  include UserHelper

  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where.not(role: 'admin')
  end

  def clients
    @clients = User.where(role: 'client')
    redirect_to :admin_users_clients_path
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
    @admin.toggle!(:enable)
    @admin.save(validate: false)

    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User status successfully updated.' }
    end
  end

  def destroy
  end


  private

  def set_admin
    @admin = User.find(params[:id])
  end

  def admin_user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end
end
