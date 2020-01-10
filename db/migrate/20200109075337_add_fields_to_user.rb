class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :cnic, :string
    add_column :users, :phone_number, :string
    add_column :users, :role, :integer, default: 0
  end
end
