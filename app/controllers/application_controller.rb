class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_categories

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by_id(session["user_id"]) if session["user_id"]
  end

  def logged_in?
    current_user != nil
  end

  private

  def set_categories
    @categories = Category.all
  end

  def require_creator_or_admin
    unless logged_in? && ( current_user.is_admin? || self.user == current_user)
      show_err "You can't do that"
    end
  end

  def require_user
    show_err "You must log in to perform this action." unless logged_in?
  end

  def require_admin
    show_err "You can't do that." unless logged_in? && current_user.is_admin?
  end

  def show_err(err_msg)
    respond_to do |format|
      format.html do
        flash[:error] = err_msg
        redirect_to root_path
      end
      format.js { render "shared/error", locals: { msg: err_msg } }
    end
  end

  def save_vote(voted_obj)
    @voted_obj_html_id = "#{voted_obj.class.name.downcase}_#{voted_obj.id}_vote"
    @obj = voted_obj
    @vote_path = :"vote_#{voted_obj.class.name.downcase}_path"
    @revote_path = :"revote_#{voted_obj.class.name.downcase}_path"
    @vote.save
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Voted!"
          redirect_to :back
        else
          flash[:error] = "Something wrong"
          redirect_to :back
        end
      end
      format.js do
        if @vote.valid?
          render "votes/vote"
        else
          render "votes/vote_error"
        end
      end
    end
  end

  def update_vote
    if @vote.vote == nil
      if params[:vote] == "true"
        @vote.vote = true
      else
        @vote.vote = false
      end
    else
      @vote.vote = nil
    end
  end

end
