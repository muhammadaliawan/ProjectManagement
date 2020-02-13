# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_project
  before_action :set_payment, only: %i[edit update destroy]
  before_action :convert_string_to_datatime, only: %i[create update]

  def new
    @payment = @project.payments.new
    authorize @payment
  end

  def edit
    authorize @payment
  end

  def create
    @payment = @project.payments.new(payment_params)
    authorize @payment
    @success = @payment.save
  end

  def update
    authorize @payment
    @payment.update(payment_params)
  end

  def destroy
    authorize @payment
    @success = @payment.destroy
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_payment
    @payment = @project.payments.find(params[:id])
  end

  def convert_string_to_datatime
    params['payment']['date'] = DateTime.strptime(params['payment']['date'],'%m/%d/%Y %H:%M %p') if params['payment']['date']
  end

  def payment_params
    params.require(:payment).permit(:amount, :date, :details)
  end
end
