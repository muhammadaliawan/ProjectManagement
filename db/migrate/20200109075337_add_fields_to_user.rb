# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, limit: 10
    add_column :users, :address, :string, limit: 100
    add_column :users, :cnic, :string, limit: 13
    add_column :users, :phone_number, :string
    add_column :users, :role, :integer, default: 0
  end
end
