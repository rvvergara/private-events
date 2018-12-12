class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created! Welcome"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
