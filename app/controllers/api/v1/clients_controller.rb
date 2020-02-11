# frozen_string_literal: true

class Api::V1::ClientsController < Api::ApiController
  before_action :set_client, only: %i[show update destroy]
  before_action :user_authentication, only: %i[create update destroy]

  def index
    @clients = Client.all
    success_response(@clients, :ok)
  end

  def show
    @project = Project.find(params[:project_id])
    @client = @project.client.find(params[:id])
    success_response(@client, :ok)
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      success_response(@client, :created)
    else
      render json: @client.errors
    end
  end

  def update
    if @client.save
      success_response(@client, :updated)
    else
      render json: @client.errors
    end
  end

  def destroy
    @client.destroy

    if @client.destroy
      success_response(@client, :deleted)
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
