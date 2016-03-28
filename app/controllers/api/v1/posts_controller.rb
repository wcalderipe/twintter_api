class Api::V1::PostsController < Api::V1::BaseController
  def index
    authorize Post
    render_collection(posts, ::V1::PostSerializer)
  end

  def show
    authorize post
    render json: post, status: 200, serializer: ::V1::PostSerializer
  end

  def create
    post = Post.new(post_params)
    authorize post
    if post.save
      render json: post, status: 201, serializer: ::V1::PostSerializer
    else
      fail ModelValidationError.new(post.errors)
    end
  end

  protected

    def post
      @post ||= Post.find_by!(id: params[:id], user_id: params[:user_id])
    end

    def posts
      Post.where(user_id: params[:user_id]).paginate(:page => params[:page])
        .order('updated_at DESC')
    end

    def post_params
      params.require(:post).permit(:text).merge({ user_id: params[:user_id] })
    end
end
