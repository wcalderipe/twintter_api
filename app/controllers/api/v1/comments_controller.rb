class Api::V1::CommentsController < Api::V1::BaseController
  def index
    authorize Comment
    render_collection(comments, ::V1::CommentIndexSerializer)
  end

  def show
    authorize comment
    render json: comment, status: 200, serializer: ::V1::CommentSerializer
  end

  def create
    comment = Comment.new(comment_params)
    authorize comment
    if comment.save
      render json: comment, status: 201, serializer: ::V1::CommentSerializer
    else
      fail ModelValidationError.new(comment.errors)
    end
  end

  def update
    authorize comment
    if comment.update(comment_params)
      render json: comment, status: 200, serializer: ::V1::CommentSerializer
    else
      fail ModelValidationError.new(comment.errors)
    end
  end

  def destroy
    authorize comment
    comment.destroy
    head 204
  end

  protected

    def comment
      @comment ||= Comment.find_by!(id: params[:id], post_id: params[:post_id])
    end

    def comments
      Comment.where(post_id: params[:post_id]).paginate(:page => params[:page])
        .order('created_at DESC')
    end

    def comment_params
      params.require(:comment).permit(:text).merge({ post_id: params[:post_id] })
    end
end
