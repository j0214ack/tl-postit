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

    case @vote.vote
    when true
      if params[:vote] == "true"
        @vote.vote = nil
      else
        @vote.vote = false
      end
    when false
      if params[:vote] == "true"
        @vote.vote = true
      else
        @vote.vote = nil
      end
    when nil
      if params[:vote] == "true"
        @vote.vote = true
      else
        @vote.vote = false
      end
    end

    if @vote.save
      flash[:notice] = "Voted!"
      redirect_to :back
    else
      flash[:error] = "Something wrong"
      redirect_to :back
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = @comment.votes.build(vote: params[:vote], user: current_user)

    if @vote.save
      flash[:notice] = "Voted!"
      redirect_to :back
    else
      flash[:error] = "Something wrong"
      redirect_to :back
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
