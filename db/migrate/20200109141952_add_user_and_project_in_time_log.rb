class AddUserAndProjectInTimeLog < ActiveRecord::Migration[5.2]
  def change
    add_reference :time_logs, :user, foreign_key: true
    add_reference :time_logs, :project, foreign_key: true
  end
end
