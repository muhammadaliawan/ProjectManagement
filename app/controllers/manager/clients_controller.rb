# frozen_string_literal: true

class Manager::ClientsController < ClientsController
  def new
    @client = Client.new
    authorize @client, policy_class: Manager::ClientPolicy
  end

  def edit
    authorize @client, policy_class: Manager::ClientPolicy
  end

  def create
    @client = Client.new(client_params)
    authorize @client, policy_class: Manager::ClientPolicy

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @client, policy_class: Manager::ClientPolicy

    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @client, policy_class: Manager::ClientPolicy

    @client.destroy
    redirect_to clients_path, notice: 'Client was successfully destroyed.'
  end
end
