class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    # Create the user model with our create parameters
    @user = User.new(user_params)

    # Try to save the user, redirect if success, re-render if failure
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    # Find the user model with our update parameters
    @user = User.find(params[:id])

    # Try to update the user, redirect if success, re-render if failure
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    # Find the user model with our destroy parameters
    @user = User.find(params[:id])

    # Destroy the user
    @user.destroy

    # Redirect to the user index
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
