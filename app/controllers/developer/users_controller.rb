# frozen_string_literal: true

class Developer::UsersController < UsersController
  before_action :set_developer, only: %i[show edit update destroy]

  def index
    @clients = User.where(role: 'client')
    @projects = Project.where(id: current_user.id)
    @time_logs = TimeLog.where(id: current_user.id)
    @developers = User.where(id: current_user.id)
  end

  private

  def set_developer
    @developer = User.find(params[:id])
  end

  def developer_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role)
  end
end
