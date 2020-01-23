# frozen_string_literal: true

class RenameColumnsInProjects < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :time_log, :hours_logged
    rename_column :projects, :total_payments, :total_payments
  end
end
