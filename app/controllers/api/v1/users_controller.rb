# frozen_string_literal: true

class Api::V1::UsersController < Api::APIController
  before_action :set_users, only: %i[show update destroy]

  def index
    @users = User.all

    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])

    render json: @user, status: 200
  end

  def create
    @user = Client.new(user_params)

    if @user.save
      render json: @user, message: 'User Created', status: 200
    else
      render json: @user.errors
    end
  end

  def update
    if @user.save
      render json: @user, message: 'User Updated', status: 200
    else
      render json: @user.errors
    end
  end

  def destroy
    @user.destroy

    if @user.destroy
      render json: 'User Deleted', status: 200
    else
      render json: @user.errors
    end
  end

  private

  def set_client
    @user = User.find(params[:id])
  end

  def client_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation, :address)
  end
end
