class CommentsController < ApplicationController

  before_action :require_user

  def create
    # @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    # @comment.post_id = params[:post_id]
    @comment = @post.comments.build(comment_params)

    if @comment.save
      flash[:notice] = "Successfully commented."
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
