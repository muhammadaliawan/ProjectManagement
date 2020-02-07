# frozen_string_literal: true

class Admin::UsersController < UsersController
  before_action :set_admin, only: %i[enable_disable_user show edit update destroy]

  def index
    @users = User.except_current_user(current_user).page(params[:page])
    authorize User
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(admin_user_params)
    authorize @user

    if @user.save
      redirect_to admin_users_path, notice: 'User successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @admin.update(admin_user_params)
      redirect_to admin_users_path, notice: 'User profile successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    redirect_to admin_users_path, notice: 'User successfully deleted.'
  end

  def enable_disable_user
    @admin.toggle!(:enable)
    redirect_to admin_users_path, notice: 'User status successfully updated.'
  end

  def search
    authorize User

    if params[:search].blank?
      redirect_to generic_path_method('index', 'project', @projects), alert: 'Empty field!'
    else
      @parameter = params[:search].downcase
      @results = User.all.where("lower(name) LIKE :search", search: @parameter)

      if @results.blank?
        redirect_to admin_users_path, alert: 'No Such User Exists'
      end
    end
  end

  private

  def set_admin
    @admin = User.find(params[:id])
    authorize @admin
  end

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end
end
