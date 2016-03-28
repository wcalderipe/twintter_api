class V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :post

  def post
    { id: object.post.id }
  end
end
