# frozen_string_literal: true

class ChangeTimeToDateTimeInTimeLog < ActiveRecord::Migration[5.2]
  def change
    change_column :time_logs, :start_time, :datetime
    change_column :time_logs, :end_time, :datetime
  end
end
