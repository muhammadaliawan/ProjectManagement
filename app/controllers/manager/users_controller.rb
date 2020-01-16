class Manager::UsersController < UsersController

  before_action :set_manager, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:show_client, :edit_client, :update_client, :destroy_client]

  def index
    @managers = User.where(role: 'manager')
    # authorize @managers
  end

  def show
  end

  def new
    @manager = User.new
    authorize @manager
  end

  def create
    @manager = User.new(manager_user_params)
    check_role
    respond_to do |format|
      if @manager.save(validate: false)
        format.html { redirect_to manager_users_path, notice: 'Client successfully created.' }
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

  def clients
    @clients = User.all_clients
  end

  def new_client
    @client = User.new
  end

  def show_client
  end

  def edit_client
  end

  def create_client
    @client = User.new(manager_user_params)
    check_client_role

    respond_to do |format|
      if @client.save
        format.html { redirect_to manager_users_path, notice: 'Client successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update_client
    respond_to do |format|
      if @client.update(manager_user_params)
        check_client_role
        format.html { redirect_to clients_manager_users_url, notice: 'Client Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy_client
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_manager_users_url, notice: 'Client successfully deleted.' }
    end
  end

  private

  def check_client_role
    if params[:user][:client].to_i == 1
      @client.role = 'client'
      @client.save(validate: false)
    end
  end

  def set_client
    @client = User.find(params[:id])
  end

  def set_manager
    @manager = User.find(params[:id])
    authorize @manager
  end

  def manager_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role)
  end

end
