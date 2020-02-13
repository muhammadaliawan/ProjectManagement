# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @clients = Client.all.search(params[:query])
    else
      @clients = Client.all
    end
    @clients = @clients.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @projects = @client.projects
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :email, :address)
  end
end
