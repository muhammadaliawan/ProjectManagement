module ApplicationHelper


  def users_home_path()
    return admin_users_path(current_user) if current_user.admin?
    return manager_users_path(current_user) if current_user.manager?
    return developer_users_path(current_user) if current_user.developer?
  end
end
