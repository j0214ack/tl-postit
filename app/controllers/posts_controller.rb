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
    @post.user = User.first

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
    @post.user = User.first
    if @post.update(post_params)
      # redirect_to post_path(@post)
      flash[:notice] = "You've successfully edited this post."
      redirect_to @post
    else
      render "edit"
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
