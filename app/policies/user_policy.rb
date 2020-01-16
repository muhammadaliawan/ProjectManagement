class UserPolicy < ApplicationPolicy

  # def index?
  #   user.admin?
  # end

  # def edit?
  #   return (user.id == record.id) unless user.admin?
  # end

  # def update?
  #   return (user.id == record.id) unless user.admin?
  # end

  # def edit_password?
  #   return (user.id == record.id) unless user.admin?
  # end

  # def update_password?
  #   return (user.id == record.id) unless user.admin?
  # end

    def index?
    user.admin?
  end

  def show?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def new?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def create?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def edit?
    if user.admin? || (user.id == record.id)
      true
    else
      false
    end
  end

  def update?
    if user.admin? || (user.id == record.id)
      true
    else
      false
    end
  end

  def destroy?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def edit_password?
    if user.admin? || (user.id == record.id)
      true
    else
      false
    end
  end

  def update_password?
    if user.admin? || (user.id == record.id)
      true
    else
      false
    end
  end

  def enable_disable_user?
    user.admin?
  end

  def cients?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

end
