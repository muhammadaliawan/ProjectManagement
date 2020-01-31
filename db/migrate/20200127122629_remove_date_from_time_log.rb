# frozen_string_literal: true

class RemoveDateFromTimeLog < ActiveRecord::Migration[5.2]
  def change
    remove_column :time_logs, :date
  end
end
