class PostPolicy < ApplicationPolicy
  def create?
    grant?
  end

  def update?
    grant?
  end

  def destroy?
    grant?
  end

  protected

    def grant?
      return false if user.guest?
      return false if user.user? && (record.user_id != user.id)
      true
    end
end
