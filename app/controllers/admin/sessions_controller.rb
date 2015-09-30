class Admin::SessionsController < Admin::UsersController
  before_filter :restrict_access

  def create  
    user = User.find(params[:user_id])
    session[:admin_id] = session[:user_id]
    session[:user_id] = params[:user_id]
    redirect_to movies_path, notice: "Logged in as #{user.firstname}!"
  end

  def destroy
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to admin_users_path
  end



end
