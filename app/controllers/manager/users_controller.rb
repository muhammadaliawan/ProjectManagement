class Manager::UsersController < UsersController

  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    @managers = User.where(role: 'manager')
  end

  def clients
    @clients = User.all_clients
  end

  def show
  end

  def new
    @manager = User.new
  end

  def create
    @manager = User.new(manager_user_params)
    check_role
    respond_to do |format|
      if @manager.save(validate: false)
        format.html { redirect_to manager_users_path, notice: 'Time log was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @manager.update(manager_user_params)
        format.html { redirect_to manager_users_url, notice: 'User Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @manager.destroy
    respond_to do |format|
      format.html { redirect_to manager_users_url, notice: 'Client successfully deleted.' }
    end
  end


  private

  def check_role
    if params[:user][:client].to_i == 1
      @manager.role = 'client'
      @manager.save(validate: false)
    end
  end

  def set_manager
    @manager = User.find(params[:id])
  end

  def manager_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role)
  end

end
