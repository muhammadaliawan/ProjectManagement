# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.page params[:page]
  end

  def show
    @projects = @client.projects
  end

  def search
    if params[:search].blank?
      redirect_to @clients, alert: 'Empty field!'
    else
      @parameter = params[:search].downcase
      @results = Client.all.where("lower(name) LIKE :search", search: @parameter)

      if @results.blank?
        redirect_to clients_path, alert: 'No Such Client Exists'
      end
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :address)
  end
end
