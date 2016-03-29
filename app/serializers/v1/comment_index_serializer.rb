class V1::CommentIndexSerializer < ActiveModel::Serializer
  attributes :id, :text, :links, :post

  def links
    { self: api_v1_post_comment_path(object.post.id, object.id) }
  end

  def post
    { id: object.post.id, links: {
      self: api_v1_user_post_path(object.post.user.id, object.post.id) } }
  end
end
