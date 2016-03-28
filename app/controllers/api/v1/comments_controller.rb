class Api::V1::CommentsController < Api::V1::BaseController
  def index
    authorize Comment
    render_collection(comments, ::V1::CommentIndexSerializer)
  end

  protected

    def comments
      Comment.where(post_id: params[:post_id]).paginate(:page => params[:page])
        .order('created_at DESC')
    end
end
