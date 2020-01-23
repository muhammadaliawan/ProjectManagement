# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :currency
      t.datetime :date

      t.timestamps
    end
  end
end
