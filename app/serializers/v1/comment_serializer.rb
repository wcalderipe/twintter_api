class V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :links, :post

  def links
    { self: api_v1_post_comment_path(object.post.id, object.id) }
  end

  def post
    ::V1::PostSerializer.new(object.post, { scope: scope, root: false,
      serialization_options: serialization_options })
  end
end
