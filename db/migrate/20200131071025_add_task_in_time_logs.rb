# frozen_string_literal: true

class AddTaskInTimeLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :time_logs, :task, :text, null: false
  end
end
