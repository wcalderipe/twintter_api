class PostPolicy < ApplicationPolicy
  def create?
    return false if user.guest?
    return false if user.user? && (record.user_id != user.id)
    true
  end
end
