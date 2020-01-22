# frozen_string_literal: true

class AddValidationInClients < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :name, :string, limit: 15, null: false
    change_column :clients, :email, :string, null: false
    change_column :clients, :address, :text, null: false
  end
end
