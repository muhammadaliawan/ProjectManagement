class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || (user.id == record.id)
  end

  def new?
    if user.admin?
      true
    else
      false
    end
  end

  def create?
    if user.admin?
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

  def show_client?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def new_client?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def create_client?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def edit_client?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def update_client?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end

  def destroy_client?
    if user.admin? || user.manager?
      true
    else
      false
    end
  end
end
