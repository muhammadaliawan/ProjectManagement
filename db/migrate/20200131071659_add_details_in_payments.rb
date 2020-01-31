# frozen_string_literal: true

class AddDetailsInPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :details, :text, null: false
  end
end
