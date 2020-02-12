# frozen_string_literal: true

class Api::V1::UsersController < Api::ApiController
  before_action :user_authentication_is_admin
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    success_response(@users)
  end

  def show
    success_response(@user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      success_response(@user, :created)
    else
      failure_response(@user.errors)
    end
  end

  def update
    if @user.update(user_params)
      success_response(@user, :updated)
    else
      failure_response(@user.errors)
    end
  end

  def destroy
    if @user.destroy
      success_response(@user, :deleted)
    else
      failure_response(@user.errors)
    end
  end

  private

  def find_user
    @user = User.find_by_email!(params[:email])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_authentication_is_admin
    raise Pundit::NotAuthorizedError unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end
end
