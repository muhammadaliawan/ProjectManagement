class UsersController < ApplicationController

  before_action :set_user, only: [:update]

  def update
    respond_to do |format|
      if @user.update(user_params)
        check_role
        format.html { redirect_to admin_users_path, notice: 'User Profile successfully updated.' }
      else
        format.html { render :edit }
      end
    end
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :role, :enable)
  end

end
