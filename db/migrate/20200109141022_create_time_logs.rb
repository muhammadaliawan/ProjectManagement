# frozen_string_literal: true

class CreateTimeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_logs do |t|
      t.time :start_time
      t.time :end_time
      t.datetime :date

      t.timestamps
    end
  end
end
