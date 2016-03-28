class CommentPolicy < ApplicationPolicy
  def create?
    grant_create?
  end
end
