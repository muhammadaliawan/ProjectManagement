# frozen_string_literal: true

class Api::V1::PaymentsController < Api::ApiController
  before_action :user_authentication
  before_action :set_project
  before_action :set_payment, only: %i[show update destroy]

  def index
    @payments = Payment.all
    authorize @payments, class_name: PaymentPolicy
    success_response(@payment)
  end

  def show
    authorize @payment, class_name: PaymentPolicy
    success_response(@payment)
  end

  def create
    @payment = @project.payments.new(payment_params)
    authorize @payment, class_name: PaymentPolicy

    if @payment.save
      success_response(@payment, :created)
    else
      failure_response(@project.errors)
    end
  end

  def update
    authorize @payment, class_name: PaymentPolicy

    if @payment.update(payment_params)
      success_response(@payment, :updated)
    else
      failure_response(@project.errors)
    end
  end

  def destroy
    authorize @payment, class_name: PaymentPolicy

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
