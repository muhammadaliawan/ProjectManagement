# frozen_string_literal: true

class RenameColumnInPayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :amount, :amount
  end
end
