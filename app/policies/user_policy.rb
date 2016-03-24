class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    grant?
  end

  def destroy?
    grant?
  end

  private

    def grant?
      # grant if user is himself
      return true if user == record
      # deny if is a guest
      return false if user.guest?
      # grant for admins if record is a guest or a user
      if user.admin?
        if user != record
          return true if record.guest? || record.user?
        end
      end
      false
    end
end
