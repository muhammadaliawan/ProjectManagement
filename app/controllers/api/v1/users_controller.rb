# frozen_string_literal: true

class Api::V1::UsersController < Api::ApiController
  before_action :authorize_request, except: :create
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all

    render json: @users, status: 200
  end

  def show
    @user = User.find(params[:id])

    render json: @user, status: 200
  end

  def create
    @user = User.new(user_params)

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

  def find_user
    @user = User.find_by_email!(params[:email])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation, :address)
  end
end
