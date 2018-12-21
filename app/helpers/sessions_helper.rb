module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  # Creates a current user
  def current_user
    # 1. If there's a current session user meaning there is an existing session userID:
    if session[:user_id]
      # 2. Create a current user if not already assigned: end
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        login(user)
        @current_user = user
      end
    end
  end

  def logged_in_user
    if !logged_in?
      flash[:danger] = "Please log in first"
      redirect_to login_path
    end
  end

  # to test if a user is logged in
  def logged_in?
    !current_user.nil?
  end

  # To test whether the current signed in user is the same user in the link
  def current_user?(user)
    current_user == user
  end

  def authorized_user
    id = params[:controller] == "users" ? params[:id] : params[:creator_id]
    user = User.find_by(id: id)
    if !current_user?(user)
      flash[:danger] = "You are not authorized to do that!"
      redirect_to user_path(current_user)
    end
  end

  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
