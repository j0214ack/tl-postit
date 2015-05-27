class UsersController < ApplicationController

  before_action :require_user, except: [:new, :create, :show]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Successfully registered!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @posts = @user.posts
    @comments = @user.comments
  end

  def edit ; end

  def update
    if @user.update(user_params)
      flash[:notice] = "Successfully updated."
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :password,
                                 :password_confirmation,
                                 :time_zone)
  end

  def set_user
    @user = User.find_by(slug: params[:slug])
  end
end
