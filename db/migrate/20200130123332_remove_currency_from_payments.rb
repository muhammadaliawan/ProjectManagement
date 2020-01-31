# frozen_string_literal: true

class RemoveCurrencyFromPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :payments, :currency
  end
end
