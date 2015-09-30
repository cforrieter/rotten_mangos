class Admin::SessionsController < ApplicationController

  def create
    user = User.find(params[:user_id])

    if user 
      session[:admin_id] = session[:user_id]
      session[:user_id] = params[:user_id]
      redirect_to movies_path, notice: "Logged in as #{user.firstname}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :index
    end
  end

  def destroy
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to admin_users_path
  end



end
