# frozen_string_literal: true

class Api::V1::UsersController < Api::ApiController
  before_action :set_user, only: %i[show update destroy]
  before_action :user_authentication, only: %i[create update destroy]

  def index
    @users = User.all
    success_response(@users, :ok)
  end

  def show
    success_response(@user, :ok)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      success_response(@user, :created)
    else
      render json: @user.errors
    end
  end

  def update
    if @user.save
      success_response(@user, :updated)
    else
      render json: @user.errors
    end
  end

  def destroy
    @user.destroy

    if @user.destroy
      success_response(@user, :deleted)
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
