# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  def new
    @project = Project.find(params[:project_id])
    @payment = @project.payments.new
  end

  def show
    @project = Project.find(params[:project_id])
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @payment = @project.payments.new(payment_params)
  end

  def update
    @payment.update(payment_params)
  end

  def destroy
    @payment.destroy
  end

  private

  def set_payment
    @payment = Payment.includes(:project).find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :currency, :date, :project_id)
  end
end
