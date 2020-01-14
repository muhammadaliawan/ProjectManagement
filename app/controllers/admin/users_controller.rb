class Admin::UsersController < UsersController

  include UserHelper

  before_action :set_admin, only: [:enable_disable_user, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def clients
    @clients = User.all_clients
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = TimeLog.new(time_log_params)

    respond_to do |format|
      if @time_log.save
        format.html { redirect_to @time_log, notice: 'Time log was successfully created.' }
        format.json { render :show, status: :created, location: @time_log }
      else
        format.html { render :new }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
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

  def enable_disable_user
    @admin.toggle!(:enable)
    @admin.save(validate: false)

    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User status successfully updated.' }
    end
  end

  def show
  end

  def destroy
  end


  private

  def check_role
    if params[:user][:admin].to_i == 1
      @user.admin!
    elsif params[:user][:manager].to_i == 1
      @user.manager!
    else
      @user.developer!
    end
  end
  def set_admin
    @admin = User.find(params[:id])
  end

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end
end
