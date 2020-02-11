# frozen_string_literal: true

class Api::ApiController < ActionController::API
  before_action :authorize_request

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def user_authentication
    raise Pundit::NotAuthorizedError unless current_user.admin? || current_user.manager?
  end

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action', status: :unauthorized }
  end

  def record_not_found
    render json: { error: 'No such record exists', status: :unauthorized }
  end

  def success_response(object, status = :ok)
    render json: object, status: status
  end

  def failure_response(object, status = :forbidden)
    render json: object, status: status
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
