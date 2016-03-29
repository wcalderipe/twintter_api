class V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :first_name, :last_name, :post_ids, :links

  def links
    { self: api_v1_user_path(object.id) }
  end
end
