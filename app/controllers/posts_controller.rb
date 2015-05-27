class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote, :revote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json { render json: {post: @post, comments: @comments} }
      format.xml { render xml: {post: @post, comments: @comments} }
    end
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
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Successfully edited."
      redirect_to @post
    else
      render "edit"
    end
  end

  def revote
    @vote = @post.votes.where(user: current_user).first

    update_vote
    save_vote(@post)
  end

  def vote
    @vote = @post.votes.build(vote: params[:vote], user: current_user)

    save_vote(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :url, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:slug])
  end
end
