# frozen_string_literal: true

class Api::V1::ClientsController < Api::ApiController
  before_action :user_authentication, only: %i[create update destroy]
  before_action :set_client, only: %i[show update destroy]

  def index
    @clients = Client.all
    success_response(@clients)
  end

  def show
    success_response(@client)
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      success_response(@client, :created)
    else
      failure_response(@client.errors)
    end
  end

  def update
    if @client.update(client_params)
      success_response(@client, :updated)
    else
      failure_response(@client.errors)
    end
  end

  def destroy
    if @client.destroy
      success_response(@client, :deleted)
    else
      failure_response(@client.errors)
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
