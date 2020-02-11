# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation address cnic phone_number enable photo])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password password_confirmation current_password address cnic phone_number enable photo])
  end

  private

  def record_not_found
    flash[:alert] = 'The specified record does not exist'
    redirect_to request.referrer || root_path
  end

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    redirect_to request.referrer || root_path
  end
end
