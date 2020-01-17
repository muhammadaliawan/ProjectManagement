module UserHelper
  def roles_helper
    roles = User.roles.keys.map {|role|
      [role.titleize,role]
    }
    roles.pop
    roles
  end
end
