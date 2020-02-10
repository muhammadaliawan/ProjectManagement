# frozen_string_literal: true

class DashboardController < ActionController::Base
  include ApplicationHelper
  layout 'application'

  def index
    redirect_to home_path if user_signed_in?
  end

  def home
    @top_projects = Project.top_projects
    @bottom_projects = Project.bottom_projects

    @payments = Payment.monthly_payments
    @time_logs = TimeLog.monthly_time_logs
  end
end
