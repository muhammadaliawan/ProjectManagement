# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :details
      t.string :total_payments
      t.integer :time_log

      t.timestamps
    end
  end
end
