class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      # redirect_to post_path(@post)
      flash[:notice] = "You've successfully created this post."
      redirect_to posts_path
    else
      render "new"
    end
  end

  def edit
    unless @post.user == current_user
      flash[:error] = "You can't edit this post."
      redirect_to @post
    end
  end

  def update
    if @post.user == current_user
      if @post.update(post_params)
        flash[:notice] = "Successfully edited."
        redirect_to @post
      else
        render "edit"
      end
    else
      flash[:error] = "You can't edit this post."
      redirect_to @post
    end
  end

  def revote
    @post = Post.find(params[:id])
    @vote = @post.votes.where(user: current_user).first

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
    @post = Post.find(params[:id])
    @vote = @post.votes.build(vote: params[:vote], user: current_user)

    if @vote.save
      flash[:notice] = "Voted!"
      redirect_to :back
    else
      flash[:error] = "Something wrong"
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :url, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
