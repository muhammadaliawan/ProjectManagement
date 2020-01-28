# frozen_string_literal: true

class DashboardController < ActionController::Base
  include ApplicationHelper
  layout 'application'

  def index
    redirect_to users_home_path if user_signed_in?
  end
end