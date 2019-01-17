class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :authorized_user, only: [:edit, :update, :destroy]
  
  def index
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created! Welcome #{@user.name}!"
      login(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = "Your profile is updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])

    if !@user.nil?
      flash[:danger] = "User not found"
      redirect_to root_path
    else
      @user.delete
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
