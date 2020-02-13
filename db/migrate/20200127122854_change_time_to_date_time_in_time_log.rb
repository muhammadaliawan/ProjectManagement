# frozen_string_literal: true

class ChangeTimeToDateTimeInTimeLog < ActiveRecord::Migration[5.2]
  def change
    remove_column(:time_logs, :start_time, :time)
    remove_column(:time_logs, :end_time, :time)

    add_column :time_logs, :start_time, :datetime
    add_column :time_logs, :end_time, :datetime
  end
end
