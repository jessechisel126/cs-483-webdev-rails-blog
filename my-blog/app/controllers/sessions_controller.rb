class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(username: params[:session][:username].downcase)
  	if user.password == params[:session][:username]
  		redirect user_path(user)
  	else
  		render 'new'
  	end
  end

  def destroy
  end

end
