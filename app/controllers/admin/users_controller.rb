class Admin::UsersController < ApplicationController
  before_filter :restrict_access

  def index
    @users = User.page(params[:page]).per(2)
  end

  def restrict_access
    if !current_user || current_user.admin == false
      flash[:alert] = "You must be an admin to go there."
      redirect_to root_path
    end
  end

end
