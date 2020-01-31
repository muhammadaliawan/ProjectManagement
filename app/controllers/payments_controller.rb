# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_project
  before_action :set_payment, only: %i[show edit update destroy]

  def new
    @payment = @project.payments.new
  end

  def show; end

  def edit; end

  def create
    @payment = @project.payments.new(payment_params)
  end

  def update
    @payment.update(payment_params)
  end

  def destroy
    @payment.destroy
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_payment
    @payment = @project.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :date, :project_id, :details)
  end
end
