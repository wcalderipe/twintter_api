class Api::V1::CommentsController < Api::V1::BaseController
  def index
    authorize Comment
    render_collection(comments, ::V1::CommentIndexSerializer)
  end

  def show
    authorize comment
    render json: comment, status: 200, serializer: ::V1::CommentSerializer
  end

  protected

    def comment
      @comment ||= Comment.find_by!(id: params[:id], post_id: params[:post_id])
    end

    def comments
      Comment.where(post_id: params[:post_id]).paginate(:page => params[:page])
        .order('created_at DESC')
    end
end
