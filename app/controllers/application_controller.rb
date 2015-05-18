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

  def require_user
    unless logged_in?
      flash[:error] = "You must log in to perform this action."
      redirect_to root_path
    end
  end

end
