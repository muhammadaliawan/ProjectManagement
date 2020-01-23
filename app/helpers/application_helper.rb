# frozen_string_literal: true

module ApplicationHelper
  def users_home_path
    return admin_users_path if current_user.admin?
    return manager_clients_path if current_user.manager?
    return developer_users_path if current_user.developer?
  end
end
