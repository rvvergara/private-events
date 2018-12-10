class SessionsController < ApplicationController
  def new
    
  end

  def create
   @user = User.find_by(username: params[:session][:username])
   if @user && @user.authenticate(params[:session][:password])
    login(@user)
    redirect_to @user
   else
    flash.now[:danger] = "Wrong username or password"
    redirect_to root_path
   end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
