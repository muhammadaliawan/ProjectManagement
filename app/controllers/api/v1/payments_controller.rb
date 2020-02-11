# frozen_string_literal: true

class Api::V1::PaymentsController < Api::ApiController
  def index
    @payments = Payment.all
    success_response(@payments, :ok)
  end

  def show
    @project = Project.find(params[:project_id])
    @payment = @project.payments.find(params[:id])
    success_response(@payment, :ok)
  end
end
