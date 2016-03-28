class CommentPolicy < ApplicationPolicy
  def create?
    grant_create?
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
    return false if user.user? && (record.post.user.id != user.id)
    true
  end
end
