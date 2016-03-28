class Api::V1::PostsController < Api::V1::BaseController
  def index
    authorize Post
    render_collection(posts, ::V1::PostSerializer)
  end

  protected

    def posts
      Post.where(user_id: params[:user_id]).paginate(:page => params[:page])
        .order('updated_at DESC')
    end
end
