class V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :user

  def user
    { id: object.user.id }
  end
end
