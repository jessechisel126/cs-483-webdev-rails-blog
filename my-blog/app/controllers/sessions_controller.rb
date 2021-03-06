class SessionsController < ApplicationController

  def new
  end

  def create
  	# Find the user by the input username
  	user = User.find_by(username: params[:session][:username].downcase)
	
  	# If user exists and authenticates, log them in
  	# Otherwise re-render new session page
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		redirect_to root_path
  	else
  		flash.now[:danger] = 'Invalid username/password combination'
  		render 'new'
  	end
  end

  def destroy
  	# Log out the current user and redirect to home
  	logout
  	redirect_to '/'
  end

end
