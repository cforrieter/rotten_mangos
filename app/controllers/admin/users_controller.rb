class Admin::UsersController < ApplicationController
  before_filter :restrict_access

  def index
    @users = User.page(params[:page]).per(2)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:alert] = "User updated"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.full_name} successfully deleted."

  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "User created successfully"
    else
      flash[:alert] = "User creation failed"
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

  def restrict_access
    if !current_user || current_user.admin == false
      flash[:alert] = "You must be an admin to go there."
      redirect_to root_path
    end
  end

end
