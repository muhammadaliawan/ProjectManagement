class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def edit_password; end

  def update_password
    if current_user.update(user_params)
      # Sign in the user by passing validation in case their password changed
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
