# frozen_string_literal: true

module ApplicationHelper
  def users_home_path
    return admin_users_path if current_user.admin?
    return manager_clients_path if current_user.manager?
    return developer_projects_path if current_user.developer?
  end

  def date_format(date)
    date.strftime('%d %B, %Y %I:%M:%S %p')
  end

  def capitalize(data)
    data.capitalize
  end

  def generic_path_method(action, model, params = {})
    self.send("#{format_action(action)}#{current_user.role}_#{format_model_name(action, model)}_path", params)
  end

  private

  def format_model_name(action, model)
    return model.pluralize if action.in? %w[index create]

    model
  end

  def format_action(action)
    return '' unless action.in? %w[new edit]

    [action, '_'].join
  end
end
