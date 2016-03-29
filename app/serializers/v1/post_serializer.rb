class V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :comment_ids, :links, :user

  def links
    { self: api_v1_user_post_path(object.user.id, object.id) }
  end

  def user
    ::V1::UserSerializer.new(object.user, { scope: scope, root: false,
      serialization_options: serialization_options })
  end
end
