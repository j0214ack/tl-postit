class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      flash[:notice] = "Successfully logged in."
      redirect_to root_path
    else
      username = params[:username]

      flash[:error] = "Something wrong, please try again"
      render "new"
    end
  end

  def destroy
    flash[:notice] = "Logged out."

    session[:user_id] = nil
    redirect_to root_path
  end
end
