class WelcomeController < ActionController::Base
  include ApplicationHelper

  def index
    redirect_to users_home_path if user_signed_in?
  end
end
