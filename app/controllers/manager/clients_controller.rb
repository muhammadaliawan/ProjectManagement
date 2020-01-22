# frozen_string_literal: true

class Manager::ClientsController < ClientsController
  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: 'Client was successfully destroyed.'
  end
end
