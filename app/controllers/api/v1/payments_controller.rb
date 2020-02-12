# frozen_string_literal: true

class Api::V1::PaymentsController < Api::ApiController
  before_action :user_authentication
  before_action :set_project
  before_action :set_payment, only: %i[show update destroy]

  def index
    @payments = Payment.all
    success_response(@payment)
  end

  def show
    success_response(@payment)
  end

  def create
    @payment = @project.payments.new(payment_params)

    if @payment.save
      success_response(@payment, :created)
    else
      failure_response(@project.errors)
    end
  end

  def update
    if @payment.update(payment_params)
      success_response(@payment, :updated)
    else
      failure_response(@project.errors)
    end
  end

  def destroy
    if @payment.destroy
      success_response(@payment, :deleted)
    else
      failure_response(@project.errors)
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_payment
    @payment = @project.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :date, :details)
  end
end
