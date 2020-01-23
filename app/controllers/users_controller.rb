# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show edit_password update_password]

  def edit_password; end

  def update_password
    if current_user.update(user_params)
      bypass_sign_in(current_user)
      current_user.save(validate: false)
      redirect_to users_home_path
    else
      render :edit_password
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end
end
