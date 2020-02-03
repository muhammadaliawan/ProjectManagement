# frozen_string_literal: true

module ProjectHelper
  def project_total_payments(project)
    project.payments.to_a.sum(&:amount)
  end

  def project_hours_logged(project)
    time = 0
    project.time_logs.each do |time_log|
      time += ((time_log.end_time - time_log.start_time) / 60 / 60).to_i
    end
    time
  end
end
