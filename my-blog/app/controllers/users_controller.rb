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

  def leave
    @user = User.find(params[:id])
  end

  def create
    # Create the contributor model with our create parameters
    @user = User.new(user_params)

    # If an admin is signing someone else up, make new user admin as well
    # Otherwise, it's just another contributor
    if admin?
      @user.type = "Administrator"
    else
      @user.type = "Contributor"
    end

    # Try to save the user, redirect if success, re-render if failure
    if @user.save
      login @user
      flash[:success] = 'Account created!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    # Find the user model with our update parameters
    @user = User.find(params[:id])

    # Try to update the user, redirect if success, re-render if failure
    if @user.update(user_params)
      flash[:success] = 'Password updated!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # Find the user model with our destroy parameters
    @user = User.find(params[:id])

    # Check author or admin is logged in
    unless admin? or is_logged_in_user? @user
      flash[:danger] = "You aren't an admin or the user!"
      redirect_to users_path
      return
    end

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
