class Admin::UsersController < UsersController

  include UserHelper

  before_action :set_admin, only: [:enable_disable_user, :show, :edit, :update, :destroy]
  before_action :set_client, only: [:show_client, :edit_client, :update_client, :destroy_client]

  def index
    @users = User.all_except(current_user)
    authorize @users
  end

  def show
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(admin_user_params)
    authorize @user
    check_role

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @admin.update(admin_user_params)
        check_role
        format.html { redirect_to admin_users_url, notice: 'User Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
    authorize @admin
  end

  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User successfully deleted.' }
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
    @client = User.new(admin_user_params)
    check_client_role

    respond_to do |format|
      if @client.save
        format.html { redirect_to admin_users_path, notice: 'User successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update_client
    respond_to do |format|
      if @client.update(admin_user_params)
        check_client_role
        format.html { redirect_to clients_admin_users_url, notice: 'User Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy_client
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_admin_users_url, notice: 'Client successfully deleted.' }
    end
  end

  def enable_disable_user
    @admin.toggle!(:enable)
    @admin.save(validate: false)

    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User status successfully updated.' }
    end
  end

  private

  def check_role
    if params[:user][:admin] == '{}'
      @user.admin!
    elsif params[:user][:manager] == '{}'
      @user.manager!
    else
      @user.developer!
    end
  end

  def check_client_role
    if params[:user][:client].to_i == 1
      @client.role = 'client'
      @client.save(validate: false)
    end
  end

  def set_client
    @client = User.find(params[:id])
  end

  def set_admin
    @admin = User.find(params[:id])
    authorize @admin
  end

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end
end
