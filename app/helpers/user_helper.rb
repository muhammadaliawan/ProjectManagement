# frozen_string_literal: true

module UserHelper
  def roles_helper
    roles = User.roles.keys.map { |role| [role.titleize, role] }
  end
end
