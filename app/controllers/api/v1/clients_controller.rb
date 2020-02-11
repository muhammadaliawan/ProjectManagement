# frozen_string_literal: true

class Api::V1::ClientsController < Api::APIController
  before_action :set_client, only: %i[show update destroy]

  def index
    @clients = Client.all

    render json: @clients, status: 200
  end

  def show
    @project = Project.find(params[:project_id])
    @client = @project.client.find(params[:id])

    render json: @client, status: 200
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, message: 'Client Created', status: 200
    else
      render json: @client.errors
    end
  end

  def update
    if @client.save
      render json: @client, message: 'Client Updated', status: 200
    else
      render json: @client.errors
    end
  end

  def destroy
    @client.destroy

    if @client.destroy
      render json: 'Client Deleted', status: 200
    else
      render json: @client.errors
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email)
  end
end
