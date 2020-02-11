# frozen_string_literal: true

class Api::V1::PaymentsController < Api::ApiController
  before_action :authorize_request, except: :create

  def index
    @payments = Payment.all

    render json: @payments, status: 200
  end

  def show
    @project = Project.find(params[:project_id])
    @payment = @project.payments.find(params[:id])

    render json: @payment, status: 200
  end
end
