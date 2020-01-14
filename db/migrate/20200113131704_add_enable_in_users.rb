class AddEnableInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :enable, :boolean, default: false, null: false
  end
end
