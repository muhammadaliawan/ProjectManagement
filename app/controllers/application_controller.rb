class ApplicationController < ActionController::Base
  
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include ApplicationHelper

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :address, :cnic, :phone_number, :enable])

    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password, :address, :cnic, :phone_number, :enable])
  end

  private

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    redirect_to (request.referrer || root_path)
  end

end
