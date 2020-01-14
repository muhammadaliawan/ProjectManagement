class WelcomeController < ActionController::Base
  include ApplicationHelper

  def index
    redirect_to users_home_path, notice: 'You are already signed in' if user_signed_in?
  end
end
