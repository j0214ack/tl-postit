class CommentsController < ApplicationController

  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Successfully commented."
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def revote
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.where(user: current_user).first

    update_vote
    save_vote(@comment)
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.build(vote: params[:vote], user: current_user)

    save_vote(@comment)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
