# frozen_string_literal: true

module ApplicationHelper
  def users_home_path
    return admin_users_path if current_user.admin?
    return manager_clients_path if current_user.manager?
    return developer_projects_path if current_user.developer?
  end

  def date_format(date)
    date.strftime('%d %B, %Y')
  end

  def capitalize(data)
    data.capitalize
  end

  def path_method(action, model, entity)

    if model == :payment && !current_user.developer?
      if action == :index
        self.send("#{current_user.role}_project_payments_path")

      elsif action == :show
        self.send("#{current_user.role}_project_payment_path", entity[0], entity[1])

      elsif action == :new
        self.send("new_#{current_user.role}_project_payment_path", entity)

      elsif action == :create
        self.send("#{current_user.role}_project_payments_path", entity)

      elsif action == :edit
        self.send("edit_#{current_user.role}_project_payment_path", entity[0], entity[1])

      elsif action == :update
        self.send("#{current_user.role}_project_payment_path", entity[0], entity[1])

      elsif action == :destroy
        self.send("#{current_user.role}_project_payment_path", entity[0], entity[1])
      end
    else
      if model == :project
        if current_user.developer?
          if action == :index
            self.send("#{current_user.role}_projects_path")
          elsif action == :show
            self.send("#{current_user.role}_project_path", entity)
          end
        else
          if action == :index
            self.send("#{current_user.role}_projects_path")

          elsif action == :show
            self.send("#{current_user.role}_project_path", entity)

          elsif action == :new
            self.send("new_#{current_user.role}_project_path", entity)

          elsif action == :create
            self.send("#{current_user.role}_projects_path", entity)

          elsif action == :edit
            self.send("edit_#{current_user.role}_project_path", entity)

          elsif action == :update
            self.send("#{current_user.role}_project_path", entity)

          elsif action == :destroy
            self.send("#{current_user.role}_project_path", entity)
          end
        end

      elsif model == :comment
        if action == :index
          self.send("#{current_user.role}_project_comments_path")

        elsif action == :show
          self.send("#{current_user.role}_project_comment_path", entity[0], entity[1])

        elsif action == :new
          self.send("new_#{current_user.role}_project_comment_path", entity)

        elsif action == :create
          self.send("#{current_user.role}_project_comments_path", entity)

        elsif action == :edit
          self.send("edit_#{current_user.role}_project_comment_path", entity[0], entity[1])

        elsif action == :update
          self.send("#{current_user.role}_project_comment_path", entity[0], entity[1])

        elsif action == :destroy
          self.send("#{current_user.role}_project_comment_path", entity[0], entity[1])
        end

      elsif model == :time_log
        if action == :index
          self.send("#{current_user.role}_project_time_logs_path")

        elsif action == :show
          self.send("#{current_user.role}_project_time_log_path", entity[0], entity[1])

        elsif action == :new
          self.send("new_#{current_user.role}_project_time_log_path", entity)

        elsif action == :create
          self.send("#{current_user.role}_project_time_logs_path", entity)

        elsif action == :edit
          self.send("edit_#{current_user.role}_project_time_log_path", entity[0], entity[1])

        elsif action == :update
          self.send("#{current_user.role}_project_time_log_path", entity[0], entity[1])

        elsif action == :destroy
          self.send("#{current_user.role}_project_time_log_path", entity[0], entity[1])
        end
      end
    end
  end
end
